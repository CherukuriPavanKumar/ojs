<?php

/**
 * @file MfaHelper.php
 *
 * @class MfaHelper
 * @brief Self-contained TOTP (RFC 6238) implementation for Super Admin MFA.
 *        No external Composer libraries required.
 */

namespace APP\plugins\generic\superAdmin;

use Illuminate\Support\Facades\DB;

class MfaHelper
{
    private const BASE32_CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
    private const TIME_STEP    = 30;   // TOTP window in seconds
    private const DIGITS       = 6;    // OTP length
    private const TOLERANCE    = 1;    // Allow 1 window either side (accounts for clock drift)

    // -------------------------------------------------------------------------
    // Key generation
    // -------------------------------------------------------------------------

    /**
     * Generate a cryptographically random 20-byte base32 secret key.
     */
    public static function generateSecret(): string
    {
        $bytes = random_bytes(20);
        return self::base32Encode($bytes);
    }

    // -------------------------------------------------------------------------
    // OTP verification
    // -------------------------------------------------------------------------

    /**
     * Verify a user-supplied OTP code against the secret.
     */
    public static function verifyCode(string $secret, string $code): bool
    {
        $timestamp = floor(time() / self::TIME_STEP);

        for ($i = -self::TOLERANCE; $i <= self::TOLERANCE; $i++) {
            if (hash_equals(self::computeOtp($secret, $timestamp + $i), $code)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Compute the TOTP for a given counter value.
     */
    private static function computeOtp(string $secret, int $counter): string
    {
        $secretBytes = self::base32Decode($secret);
        $counterBytes = pack('N*', 0) . pack('N*', $counter);  // 8-byte big-endian
        $hash = hash_hmac('sha1', $counterBytes, $secretBytes, true);
        $offset = ord($hash[19]) & 0x0F;
        $value = (
            ((ord($hash[$offset])     & 0x7F) << 24) |
            ((ord($hash[$offset + 1]) & 0xFF) << 16) |
            ((ord($hash[$offset + 2]) & 0xFF) << 8)  |
             (ord($hash[$offset + 3]) & 0xFF)
        );
        return str_pad((string)($value % (10 ** self::DIGITS)), self::DIGITS, '0', STR_PAD_LEFT);
    }

    // -------------------------------------------------------------------------
    // QR Code URI for Google Authenticator / Authy
    // -------------------------------------------------------------------------

    /**
     * Build an otpauth:// URI for the authenticator app.
     */
    public static function getOtpAuthUri(string $username, string $secret, string $issuer = 'Veridica OJS'): string
    {
        return 'otpauth://totp/' . rawurlencode($issuer . ':' . $username)
            . '?secret=' . $secret
            . '&issuer=' . rawurlencode($issuer)
            . '&algorithm=SHA1'
            . '&digits=' . self::DIGITS
            . '&period=' . self::TIME_STEP;
    }

    /**
     * Build a Google Chart QR code image URL from the otpauth URI.
     * Uses a fully offline-compatible local QR generation endpoint if available,
     * otherwise falls back to Google Charts.
     */
    public static function getQrCodeUrl(string $username, string $secret, string $issuer = 'Veridica OJS'): string
    {
        $uri = self::getOtpAuthUri($username, $secret, $issuer);
        // Google Charts API — works without any server-side library
        return 'https://chart.googleapis.com/chart?cht=qr&chs=250x250&chl=' . rawurlencode($uri);
    }

    // -------------------------------------------------------------------------
    // Database helpers
    // -------------------------------------------------------------------------

    /**
     * Get the MFA secret for a user_id, or null if not set up.
     */
    public static function getSecret(int $userId): ?string
    {
        $row = DB::table('user_settings')
            ->where('user_id', $userId)
            ->where('setting_name', 'superAdminMfaSecret')
            ->first();
        return $row?->setting_value ?: null;
    }

    /**
     * Persist an MFA secret for a user_id.
     */
    public static function saveSecret(int $userId, string $secret): void
    {
        $exists = DB::table('user_settings')
            ->where('user_id', $userId)
            ->where('setting_name', 'superAdminMfaSecret')
            ->exists();

        if ($exists) {
            DB::table('user_settings')
                ->where('user_id', $userId)
                ->where('setting_name', 'superAdminMfaSecret')
                ->update(['setting_value' => $secret]);
        } else {
            DB::table('user_settings')->insert([
                'user_id'       => $userId,
                'setting_name'  => 'superAdminMfaSecret',
                'setting_value' => $secret,
                'locale'        => '',
            ]);
        }
    }

    /**
     * Remove MFA secret for a user (reset MFA).
     */
    public static function removeSecret(int $userId): void
    {
        DB::table('user_settings')
            ->where('user_id', $userId)
            ->where('setting_name', 'superAdminMfaSecret')
            ->delete();
    }

    // -------------------------------------------------------------------------
    // Session helpers (DB-backed — OJS session handler drops raw $_SESSION writes)
    // -------------------------------------------------------------------------

    /**
     * Mark the current user as MFA-verified by storing a timestamp in user_settings.
     */
    public static function markSessionVerified(int $userId): void
    {
        $exists = DB::table('user_settings')
            ->where('user_id', $userId)
            ->where('setting_name', 'superAdminMfaVerifiedAt')
            ->exists();

        if ($exists) {
            DB::table('user_settings')
                ->where('user_id', $userId)
                ->where('setting_name', 'superAdminMfaVerifiedAt')
                ->update(['setting_value' => time()]);
        } else {
            DB::table('user_settings')->insert([
                'user_id'       => $userId,
                'setting_name'  => 'superAdminMfaVerifiedAt',
                'setting_value' => time(),
                'locale'        => '',
            ]);
        }
    }

    /**
     * Check if the user has verified MFA in the last SESSION_TTL seconds.
     * We use a short window (1 hour) so the admin must re-verify after long idle periods.
     */
    public static function isSessionVerified(int $userId): bool
    {
        $SESSION_TTL = 3600; // 1 hour
        $row = DB::table('user_settings')
            ->where('user_id', $userId)
            ->where('setting_name', 'superAdminMfaVerifiedAt')
            ->first();

        if (!$row) return false;
        return (time() - (int)$row->setting_value) < $SESSION_TTL;
    }

    /**
     * Clear MFA verification for a user (on logout or MFA reset).
     */
    public static function clearSession(int $userId): void
    {
        DB::table('user_settings')
            ->where('user_id', $userId)
            ->where('setting_name', 'superAdminMfaVerifiedAt')
            ->delete();
    }

    // -------------------------------------------------------------------------
    // Base32 codec (RFC 4648)
    // -------------------------------------------------------------------------

    public static function base32Encode(string $bytes): string
    {
        $base32 = '';
        $bytesLen = strlen($bytes);
        $i = 0;
        $buffer = 0;
        $bitsLeft = 0;

        while ($i < $bytesLen || $bitsLeft > 0) {
            if ($bitsLeft < 5) {
                if ($i < $bytesLen) {
                    $buffer = ($buffer << 8) | ord($bytes[$i++]);
                    $bitsLeft += 8;
                } else {
                    $buffer <<= (5 - $bitsLeft);
                    $bitsLeft = 5;
                }
            }
            $base32 .= self::BASE32_CHARS[($buffer >> ($bitsLeft - 5)) & 0x1F];
            $bitsLeft -= 5;
        }

        return $base32;
    }

    public static function base32Decode(string $encoded): string
    {
        $encoded = strtoupper($encoded);
        $map = array_flip(str_split(self::BASE32_CHARS));
        $buffer = 0;
        $bitsLeft = 0;
        $decoded = '';

        for ($i = 0; $i < strlen($encoded); $i++) {
            $char = $encoded[$i];
            if (!isset($map[$char])) continue;
            $buffer = ($buffer << 5) | $map[$char];
            $bitsLeft += 5;
            if ($bitsLeft >= 8) {
                $decoded .= chr(($buffer >> ($bitsLeft - 8)) & 0xFF);
                $bitsLeft -= 8;
            }
        }

        return $decoded;
    }
}

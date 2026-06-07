package com.example.spendlock

import android.content.Context
import android.content.SharedPreferences

object LockLaunchStore {
    private const val PREFS = "spendlock_guard_prefs"
    private const val KEY_BLOCKED_PACKAGES = "blocked_packages"
    private const val KEY_PENDING_LOCK_PACKAGE = "pending_lock_package"
    private const val KEY_LOCK_PAYLOADS = "lock_payloads"

    private fun prefs(context: Context): SharedPreferences {
        return context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
    }

    fun saveBlockedPackages(context: Context, packages: List<String>) {
        prefs(context).edit()
            .putStringSet(KEY_BLOCKED_PACKAGES, packages.toSet())
            .apply()
    }

    fun getBlockedPackages(context: Context): List<String> {
        return prefs(context).getStringSet(KEY_BLOCKED_PACKAGES, emptySet())
            ?.toList()
            ?: emptyList()
    }

    fun setPendingLockPackage(context: Context, packageName: String) {
        prefs(context).edit()
            .putString(KEY_PENDING_LOCK_PACKAGE, packageName)
            .apply()
    }

    fun peekPendingLockPackage(context: Context): String? {
        return prefs(context).getString(KEY_PENDING_LOCK_PACKAGE, null)
    }

    fun getAndClearPendingLockPackage(context: Context): String? {
        val prefs = prefs(context)
        val packageName = prefs.getString(KEY_PENDING_LOCK_PACKAGE, null)
        if (packageName != null) {
            prefs.edit().remove(KEY_PENDING_LOCK_PACKAGE).apply()
        }
        return packageName
    }

    fun clearPendingLockPackage(context: Context) {
        prefs(context).edit().remove(KEY_PENDING_LOCK_PACKAGE).apply()
    }

    fun saveLockPayloads(context: Context, payloads: Map<String, LockOverlayPayload>) {
        val root = org.json.JSONObject()
        payloads.forEach { (packageName, payload) ->
            root.put(packageName, payload.toJson())
        }
        prefs(context).edit()
            .putString(KEY_LOCK_PAYLOADS, root.toString())
            .apply()
    }

    fun getLockPayload(context: Context, packageName: String): LockOverlayPayload? {
        val raw = prefs(context).getString(KEY_LOCK_PAYLOADS, null) ?: return null
        return try {
            val root = org.json.JSONObject(raw)
            if (!root.has(packageName)) return null
            LockOverlayPayload.fromJson(root.getJSONObject(packageName))
        } catch (_: Exception) {
            null
        }
    }
}

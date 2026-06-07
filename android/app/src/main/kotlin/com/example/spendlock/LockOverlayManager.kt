package com.example.spendlock

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import android.util.Log

object LockOverlayManager {
    private const val TAG = "SpendLockOverlay"

    private var isActivityVisible = false

    var onDismissListener: (() -> Unit)? = null

    fun canDrawOverlays(context: Context): Boolean {
        return Settings.canDrawOverlays(context)
    }

    fun openOverlaySettings(context: Context) {
        val intent = Intent(
            Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
            Uri.parse("package:${context.packageName}"),
        ).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }
        context.startActivity(intent)
    }

    fun isShowing(): Boolean = isActivityVisible

    fun markActivityVisible(visible: Boolean) {
        isActivityVisible = visible
    }

    fun notifyDismissed() {
        onDismissListener?.invoke()
    }

    fun show(context: Context, packageName: String, payload: LockOverlayPayload) {
        if (isActivityVisible) {
            Log.d(TAG, "Lock overlay activity already visible")
            return
        }

        val appContext = context.applicationContext
        val intent = Intent(appContext, LockOverlayActivity::class.java).apply {
            addFlags(
                Intent.FLAG_ACTIVITY_NEW_TASK or
                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                    Intent.FLAG_ACTIVITY_SINGLE_TOP,
            )
            putExtra(LockOverlayActivity.EXTRA_BLOCKED_PACKAGE, packageName)
            putExtra(LockOverlayActivity.EXTRA_RULE_MESSAGE, payload.ruleMessage)
            putExtra(LockOverlayActivity.EXTRA_IS_LIMIT_BASED, payload.isLimitBased)
            putExtra(LockOverlayActivity.EXTRA_REMAINING_SECONDS, payload.remainingSeconds)
        }

        appContext.startActivity(intent)
        Log.d(TAG, "Lock overlay activity started for $packageName")
    }

    fun hide(context: Context) {
        LockOverlayActivity.finishIfRunning()
    }
}

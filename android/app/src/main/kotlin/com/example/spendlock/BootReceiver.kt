package com.example.spendlock

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        if (intent?.action != Intent.ACTION_BOOT_COMPLETED) return

        val packages = LockLaunchStore.getBlockedPackages(context)
        if (packages.isEmpty()) return

        Log.d(TAG, "Restarting guard service after boot")
        AppGuardService.startWithPackages(context, packages)
    }

    companion object {
        private const val TAG = "SpendLockBoot"
    }
}

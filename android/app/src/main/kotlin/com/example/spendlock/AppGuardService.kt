package com.example.spendlock

import android.app.AppOpsManager
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.Process
import android.util.Log
import androidx.core.app.NotificationCompat

class AppGuardService : Service() {
    private val handler = Handler(Looper.getMainLooper())

    private val monitorRunnable = object : Runnable {
        override fun run() {
            checkForegroundApp()
            handler.postDelayed(this, 500L)
        }
    }

    override fun onCreate() {
        super.onCreate()
        if (blockedPackages.isEmpty()) {
            blockedPackages = LockLaunchStore.getBlockedPackages(this)
        }
        createNotificationChannel()
        startForeground(NOTIFICATION_ID, buildNotification())
        handler.post(monitorRunnable)
        Log.d(TAG, "AppGuardService started with ${blockedPackages.size} packages")
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_STOP -> {
                blockedPackages = emptyList()
                LockLaunchStore.saveBlockedPackages(this, emptyList())
                stopSelf()
                return START_NOT_STICKY
            }
            ACTION_START, ACTION_UPDATE_PACKAGES -> {
                blockedPackages = intent.getStringArrayListExtra(EXTRA_BLOCKED_PACKAGES)
                    ?: emptyList()
                LockLaunchStore.saveBlockedPackages(this, blockedPackages)
                Log.d(TAG, "Blocked packages updated: ${blockedPackages.size}")
                if (blockedPackages.isEmpty()) {
                    stopSelf()
                    return START_NOT_STICKY
                }
            }
            ACTION_RESET -> {
                lastBlockedPackage = null
            }
        }
        return START_STICKY
    }

    override fun onTaskRemoved(rootIntent: Intent?) {
        super.onTaskRemoved(rootIntent)
        if (blockedPackages.isEmpty()) return
        Log.d(TAG, "Task removed — restarting guard service")
        startWithPackages(applicationContext, blockedPackages)
    }

    override fun onDestroy() {
        handler.removeCallbacks(monitorRunnable)
        super.onDestroy()
        Log.d(TAG, "AppGuardService destroyed")

        val storedPackages = LockLaunchStore.getBlockedPackages(applicationContext)
        if (storedPackages.isNotEmpty()) {
            startWithPackages(applicationContext, storedPackages)
        } else {
            blockedPackages = emptyList()
        }
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun checkForegroundApp() {
        if (blockedPackages.isEmpty()) {
            blockedPackages = LockLaunchStore.getBlockedPackages(this)
        }
        if (blockedPackages.isEmpty()) return
        if (!hasUsageStatsPermission()) return

        val foregroundPackage = getForegroundPackage() ?: return

        if (foregroundPackage == packageName) return

        if (isTemporarilyOverridden(foregroundPackage)) return

        if (!blockedPackages.contains(foregroundPackage)) {
            lastBlockedPackage = null
            return
        }

        if (lastBlockedPackage == foregroundPackage) return

        lastBlockedPackage = foregroundPackage
        Log.d(TAG, "Blocked app detected: $foregroundPackage")

        LockLaunchStore.setPendingLockPackage(this, foregroundPackage)
        AppGuardEventBridge.emitBlockedPackage(foregroundPackage)
        showLockOverlay(foregroundPackage)
    }

    private fun showLockOverlay(blockedPackage: String) {
        val payload = LockLaunchStore.getLockPayload(this, blockedPackage)
            ?: LockOverlayPayload.default(blockedPackage)
        LockOverlayManager.show(this, blockedPackage, payload)
    }

    private fun getForegroundPackage(): String? {
        val usageStatsManager =
            getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val endTime = System.currentTimeMillis()
        val startTime = endTime - 5000
        val usageEvents = usageStatsManager.queryEvents(startTime, endTime)
        val event = UsageEvents.Event()
        var lastPackage: String? = null

        while (usageEvents.hasNextEvent()) {
            usageEvents.getNextEvent(event)
            if (event.eventType == UsageEvents.Event.ACTIVITY_RESUMED ||
                event.eventType == UsageEvents.Event.MOVE_TO_FOREGROUND
            ) {
                lastPackage = event.packageName
            }
        }
        return lastPackage
    }

    private fun hasUsageStatsPermission(): Boolean {
        val appOps = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = appOps.checkOpNoThrow(
            AppOpsManager.OPSTR_GET_USAGE_STATS,
            Process.myUid(),
            packageName,
        )
        return mode == AppOpsManager.MODE_ALLOWED
    }

    private fun buildNotification(): Notification {
        val pendingIntent = PendingIntent.getActivity(
            this,
            0,
            Intent(this, MainActivity::class.java),
            PendingIntent.FLAG_IMMUTABLE,
        )

        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("SpendLock active")
            .setContentText("Monitoring selected apps in background")
            .setSmallIcon(android.R.drawable.ic_lock_lock)
            .setContentIntent(pendingIntent)
            .setOngoing(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .build()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "SpendLock App Guard",
                NotificationManager.IMPORTANCE_LOW,
            )
            channel.description = "Keeps SpendLock monitoring your selected apps"
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
    }

    companion object {
        const val ACTION_START = "com.example.spendlock.action.START_GUARD"
        const val ACTION_STOP = "com.example.spendlock.action.STOP_GUARD"
        const val ACTION_UPDATE_PACKAGES = "com.example.spendlock.action.UPDATE_PACKAGES"
        const val ACTION_RESET = "com.example.spendlock.action.RESET_GUARD"
        const val EXTRA_BLOCKED_PACKAGES = "blocked_packages"
        const val EXTRA_BLOCKED_PACKAGE = "blocked_package"
        const val EXTRA_OPEN_LOCK_SCREEN = "open_lock_screen"

        private const val TAG = "SpendLockGuard"
        private const val CHANNEL_ID = "spendlock_app_guard"
        private const val NOTIFICATION_ID = 1001

        var blockedPackages: List<String> = emptyList()
        private var lastBlockedPackage: String? = null
        private val temporaryOverrides = mutableMapOf<String, Long>()
        private const val OVERRIDE_DURATION_MS = 30 * 60 * 1000L

        fun resetLastBlockedPackage() {
            lastBlockedPackage = null
        }

        fun grantTemporaryOverride(packageName: String) {
            temporaryOverrides[packageName] =
                System.currentTimeMillis() + OVERRIDE_DURATION_MS
            lastBlockedPackage = null
            Log.d(TAG, "Temporary override granted for $packageName")
        }

        private fun isTemporarilyOverridden(packageName: String): Boolean {
            val expiry = temporaryOverrides[packageName] ?: return false
            if (System.currentTimeMillis() > expiry) {
                temporaryOverrides.remove(packageName)
                return false
            }
            return true
        }

        fun startWithPackages(context: Context, packages: List<String>) {
            if (packages.isEmpty()) return
            blockedPackages = packages
            LockLaunchStore.saveBlockedPackages(context, packages)
            val intent = Intent(context, AppGuardService::class.java).apply {
                action = ACTION_START
                putStringArrayListExtra(EXTRA_BLOCKED_PACKAGES, ArrayList(packages))
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }
    }
}

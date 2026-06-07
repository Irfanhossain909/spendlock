package com.example.spendlock

import android.app.AppOpsManager
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.os.PowerManager
import android.os.Process
import android.provider.Settings
import android.util.Log
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val methodChannelName = "com.spendlock/app_monitor"
    private val eventChannelName = "com.spendlock/app_guard_events"
    private var methodChannel: MethodChannel? = null
    private var pendingBlockedPackage: String? = null
    private val mainHandler = Handler(Looper.getMainLooper())

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, eventChannelName)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    AppGuardEventBridge.eventSink = events
                    Log.d(TAG, "EventChannel listening")
                }

                override fun onCancel(arguments: Any?) {
                    AppGuardEventBridge.eventSink = null
                    Log.d(TAG, "EventChannel cancelled")
                }
            })

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelName)
            .also { channel ->
                LockOverlayManager.onDismissListener = {
                    channel.invokeMethod("onLockOverlayDismissed", null)
                }
                channel.setMethodCallHandler { call, result ->
                    when (call.method) {
                        "getForegroundApp" -> {
                            result.success(getForegroundPackage())
                        }
                        "hasUsagePermission" -> {
                            result.success(hasUsageStatsPermission())
                        }
                        "openUsageSettings" -> {
                            startActivity(Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS))
                            result.success(true)
                        }
                        "openBatterySettings" -> {
                            openBatteryOptimizationSettings()
                            result.success(true)
                        }
                        "isBatteryOptimizationIgnored" -> {
                            result.success(isBatteryOptimizationIgnored())
                        }
                        "getLaunchLockPackage" -> {
                            val stored = LockLaunchStore.getAndClearPendingLockPackage(this)
                            val pkg = pendingBlockedPackage ?: stored
                            pendingBlockedPackage = null
                            result.success(pkg)
                        }
                        "startGuardService" -> {
                            val packages =
                                call.argument<ArrayList<String>>("blockedPackages")
                                    ?: arrayListOf()
                            startGuardService(packages)
                            result.success(true)
                        }
                        "stopGuardService" -> {
                            stopGuardService()
                            result.success(true)
                        }
                        "resetGuardState" -> {
                            resetGuardState()
                            result.success(true)
                        }
                        "flushPendingLock" -> {
                            deliverPendingBlockedPackage()
                            result.success(true)
                        }
                        "hasOverlayPermission" -> {
                            result.success(LockOverlayManager.canDrawOverlays(this))
                        }
                        "openOverlaySettings" -> {
                            LockOverlayManager.openOverlaySettings(this)
                            result.success(true)
                        }
                        "syncLockPayloads" -> {
                            syncLockPayloads(call.argument<Map<String, Any>>("payloads"))
                            result.success(true)
                        }
                        "showLockOverlay" -> {
                            showNativeLockOverlay(call.arguments)
                            result.success(true)
                        }
                        "hideLockOverlay" -> {
                            LockOverlayManager.hide(this)
                            result.success(true)
                        }
                        "isLockOverlayShowing" -> {
                            result.success(LockOverlayManager.isShowing())
                        }
                        else -> result.notImplemented()
                    }
                }
            }

        handleLockIntent(intent)
    }

    override fun onResume() {
        super.onResume()
        enableShowWhenLocked()
        deliverPendingBlockedPackage()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        handleLockIntent(intent)
    }

    private fun enableShowWhenLocked() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(true)
            setTurnScreenOn(true)
        } else {
            @Suppress("DEPRECATION")
            window.addFlags(
                WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                    WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON,
            )
        }
    }

    private fun handleLockIntent(intent: Intent?) {
        if (intent?.getBooleanExtra(AppGuardService.EXTRA_OPEN_LOCK_SCREEN, false) != true) {
            return
        }

        val blockedPackage = intent.getStringExtra(AppGuardService.EXTRA_BLOCKED_PACKAGE)
        if (blockedPackage.isNullOrEmpty()) return

        pendingBlockedPackage = blockedPackage
        LockLaunchStore.setPendingLockPackage(this, blockedPackage)
        showNativeLockOverlay(
            mapOf(
                "blockedPackage" to blockedPackage,
            ),
        )
    }

    @Suppress("UNCHECKED_CAST")
    private fun syncLockPayloads(rawPayloads: Map<String, Any>?) {
        if (rawPayloads == null) return
        val payloads = mutableMapOf<String, LockOverlayPayload>()
        rawPayloads.forEach { (packageName, value) ->
            val map = value as? Map<String, Any> ?: return@forEach
            LockOverlayPayload.fromMap(map)?.let { payloads[packageName] = it }
        }
        LockLaunchStore.saveLockPayloads(this, payloads)
    }

    private fun showNativeLockOverlay(arguments: Any?) {
        val map = arguments as? Map<*, *> ?: return
        val blockedPackage = map["blockedPackage"]?.toString() ?: return
        val payload = LockOverlayPayload.fromMap(map)
            ?: LockLaunchStore.getLockPayload(this, blockedPackage)
            ?: LockOverlayPayload.default(blockedPackage)
        LockOverlayManager.show(this, blockedPackage, payload)
    }

    private fun deliverPendingBlockedPackage(attempt: Int = 0) {
        val blockedPackage = pendingBlockedPackage
            ?: LockLaunchStore.peekPendingLockPackage(this)
            ?: return

        showNativeLockOverlay(
            mapOf(
                "blockedPackage" to blockedPackage,
            ),
        )
        pendingBlockedPackage = null
        LockLaunchStore.clearPendingLockPackage(this)
        AppGuardEventBridge.emitBlockedPackage(blockedPackage)
    }

    private fun startGuardService(packages: ArrayList<String>) {
        AppGuardService.startWithPackages(this, packages)
    }

    private fun stopGuardService() {
        LockLaunchStore.saveBlockedPackages(this, emptyList())
        val intent = Intent(this, AppGuardService::class.java).apply {
            action = AppGuardService.ACTION_STOP
        }
        startService(intent)
    }

    private fun resetGuardState() {
        LockOverlayManager.hide(this)
        AppGuardService.resetLastBlockedPackage()
        val intent = Intent(this, AppGuardService::class.java).apply {
            action = AppGuardService.ACTION_RESET
        }
        startService(intent)
    }

    private fun openBatteryOptimizationSettings() {
        if (isBatteryOptimizationIgnored()) return
        val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS).apply {
            data = Uri.parse("package:$packageName")
        }
        try {
            startActivity(intent)
        } catch (_: Exception) {
            startActivity(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))
        }
    }

    private fun isBatteryOptimizationIgnored(): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return true
        val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
        return powerManager.isIgnoringBatteryOptimizations(packageName)
    }

    private fun getForegroundPackage(): String? {
        if (!hasUsageStatsPermission()) return null

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

    companion object {
        private const val TAG = "SpendLockMain"
    }
}

package com.example.spendlock

import io.flutter.plugin.common.EventChannel

object AppGuardEventBridge {
    var eventSink: EventChannel.EventSink? = null

    fun emitBlockedPackage(packageName: String) {
        eventSink?.success(packageName)
    }

    fun resetLastBlockedPackage() {
        AppGuardService.resetLastBlockedPackage()
    }
}

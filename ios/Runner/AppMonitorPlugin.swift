import Flutter
import UIKit

final class AppMonitorPlugin: NSObject, FlutterPlugin {
    private static let channelName = "com.spendlock/app_monitor"
    private var channel: FlutterMethodChannel?

    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: registrar.messenger()
        )
        let instance = AppMonitorPlugin()
        instance.channel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "hasUsagePermission":
            result(false)
        case "openUsageSettings":
            result(true)
        case "openBatterySettings":
            result(true)
        case "isBatteryOptimizationIgnored":
            result(true)
        case "hasOverlayPermission":
            result(true)
        case "openOverlaySettings":
            result(true)
        case "startGuardService", "stopGuardService", "resetGuardState", "flushPendingLock":
            result(true)
        case "getLaunchLockPackage":
            result(nil)
        case "syncLockPayloads":
            if let args = call.arguments as? [String: Any],
               let payloads = args["payloads"] as? [String: Any] {
                LockOverlayManager.shared.savePayloads(payloads)
            }
            result(true)
        case "showLockOverlay":
            guard let args = call.arguments as? [String: Any],
                  let blockedPackage = args["blockedPackage"] as? String else {
                result(false)
                return
            }
            let payload = LockOverlayPayload.from(arguments: args)
            DispatchQueue.main.async { [weak self] in
                LockOverlayManager.shared.onDismiss = {
                    self?.channel?.invokeMethod("onLockOverlayDismissed", arguments: nil)
                }
                LockOverlayManager.shared.show(
                    blockedPackage: blockedPackage,
                    payload: payload
                )
            }
            result(true)
        case "hideLockOverlay":
            DispatchQueue.main.async {
                LockOverlayManager.shared.hide()
            }
            result(true)
        case "isLockOverlayShowing":
            result(LockOverlayManager.shared.isShowing())
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

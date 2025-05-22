import Cocoa
import OSLog

class AppDelegate: NSObject, NSApplicationDelegate  {
    
    let logger = Logger(subsystem: "org.getlantern.lantern", category: "AppDelegate")
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Activate extension on launch (consider user experience implications)

        // Observe notifications from SystemExtensionManager
        SystemExtensionManager.shared.activateExtension(bundleID: "org.getlantern.SystemExtenstionTest.PacketTunnel")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleNeedsUserApproval),
                                               name: .systemExtensionNeedsUserApproval,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleActivationSuccess),
                                               name: .systemExtensionActivationSucceeded,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleActivationFailure),
                                               name: .systemExtensionActivationFailed,
                                               object: nil)
    }

    @objc func handleNeedsUserApproval(notification: Notification) {
        guard let extensionID = notification.object as? String else { return }
        logger.log("UI: System extension \(extensionID) needs user approval.")
        //Show an alert to the user:
        let alert = NSAlert()
        // TODO: internationalize this
        alert.messageText = "Lantern System Extension Approval Needed"
        alert.informativeText = "Your Mac requires you to approve the system extension for Lantern to function correctly."
        alert.addButton(withTitle: "Open System Settings")
        alert.addButton(withTitle: "Later")

        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            SystemExtensionManager.shared.openPrivacyAndSecuritySettings()
        }
    }

    @objc func handleActivationSuccess(notification: Notification) {
        guard let extensionID = notification.object as? String else { return }
        logger.log("UI: System extension \(extensionID) activated successfully!")
        logger.log("Initing VPNManagerViewModel")
        let result = VPNManagerViewModel.init()
        //Update UI, enable features, etc.
    }

    @objc func handleActivationFailure(notification: Notification) {
        guard let extensionID = notification.object as? String else { return }
        let error = notification.userInfo?["error"] as? Error
        logger.log("UI: Failed to activate system extension \(extensionID). Error: \(error?.localizedDescription ?? "Unknown error")")
        //Show an error message to the user.
    }
}

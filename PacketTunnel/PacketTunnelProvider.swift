import NetworkExtension
import OSLog

class PacketTunnelProvider: ExtensionProvider {
    
    static let logger = Logger(subsystem: "org.getlantern.lantern", category: "PacketTunnelProvider")
    
    let logger: Logger
    
    override init() {
        self.logger = Self.logger
        logger.log(level: .debug, "PacketTunnel first light")
        super.init()
    }

    override func startTunnel(options: [String: NSObject]?) async throws {
        logger.log("PacketTunnelProvider starting tunnel")
      try await super.startTunnel(options: options)
    }
    
    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        // Add code here to start the process of stopping the tunnel.
        completionHandler()
    }
    
    override func handleAppMessage(_ messageData: Data, completionHandler: ((Data?) -> Void)?) {
        // Add code here to handle the message.
        if let handler = completionHandler {
            handler(messageData)
        }
    }
    
    override func sleep(completionHandler: @escaping () -> Void) {
        // Add code here to get ready to sleep.
        completionHandler()
    }
    
    override func wake() {
        // Add code here to wake up.
    }
}

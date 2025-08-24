import Foundation
#if canImport(Security)
import Security
#endif

final class KeychainHelper {
    static let shared = KeychainHelper()
    private init() {}

    var apiKey: String? {
        get {
            #if canImport(Security)
            // Retrieve API key securely from Keychain. Implementation omitted for brevity.
            return nil
            #else
            return ProcessInfo.processInfo.environment["OPENAI_API_KEY"]
            #endif
        }
    }
}

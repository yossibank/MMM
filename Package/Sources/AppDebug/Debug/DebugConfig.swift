import Foundation

enum DebugConfig {
    static var isTesting: Bool {
        NSClassFromString("XCTestCase") != nil
    }
}

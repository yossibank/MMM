import SwiftUI

public extension EnvironmentValues {
    var otherRouter: OtherRouter {
        get { self[OtherRouterKey.self] }
        set { self[OtherRouterKey.self] = newValue }
    }
}

private struct OtherRouterKey: EnvironmentKey {
    static let defaultValue = OtherRouter()
}

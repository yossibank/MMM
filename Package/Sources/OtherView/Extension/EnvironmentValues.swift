import SwiftUI

extension EnvironmentValues {
    var router: Router {
        get { self[RouterKey.self] }
        set { self[RouterKey.self] = newValue }
    }
}

private struct RouterKey: EnvironmentKey {
    static let defaultValue = Router()
}

import SwiftUI

public extension EnvironmentValues {
    var mainColor: Binding<Color> {
        get { self[MainColorKey.self] }
        set { self[MainColorKey.self] = newValue }
    }
}

private struct MainColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(Color.green)
}

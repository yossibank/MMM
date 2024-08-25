import SwiftUI

public extension EnvironmentValues {
    var mainColor: Binding<Color> {
        get { self[MainColorKey.self] }
        set { self[MainColorKey.self] = newValue }
    }

    var colorMode: Binding<ColorMode> {
        get { self[ColorModeKey.self] }
        set { self[ColorModeKey.self] = newValue }
    }
}

private struct MainColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(Color.green)
}

private struct ColorModeKey: EnvironmentKey {
    static let defaultValue = Binding.constant(ColorMode.light)
}

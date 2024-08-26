import SwiftUI

public extension EnvironmentValues {
    var colorTheme: Binding<ColorTheme> {
        get { self[ColorThemeKey.self] }
        set { self[ColorThemeKey.self] = newValue }
    }

    var colorMode: Binding<ColorMode> {
        get { self[ColorModeKey.self] }
        set { self[ColorModeKey.self] = newValue }
    }

    var isGradation: Binding<Bool> {
        get { self[GradationKey.self] }
        set { self[GradationKey.self] = newValue }
    }
}

private struct ColorThemeKey: EnvironmentKey {
    static let defaultValue = Binding.constant(ColorTheme.green)
}

private struct ColorModeKey: EnvironmentKey {
    static let defaultValue = Binding.constant(ColorMode.light)
}

private struct GradationKey: EnvironmentKey {
    static let defaultValue = Binding.constant(false)
}

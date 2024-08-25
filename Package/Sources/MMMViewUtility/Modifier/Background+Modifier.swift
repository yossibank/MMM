import SwiftUI

public struct BackgroundModifier: ViewModifier {
    @Environment(\.colorTheme) private var colorTheme
    @Environment(\.isGradation) private var isGradation

    private let alpha: CGFloat

    public init(alpha: CGFloat) {
        self.alpha = alpha
    }

    public func body(content: Content) -> some View {
        if isGradation.wrappedValue {
            content.background(colorTheme.wrappedValue.color.opacity(alpha).gradient)
        } else {
            content.background(colorTheme.wrappedValue.color.opacity(alpha))
        }
    }
}

public struct ActiveBackgroundModifier: ViewModifier {
    @Environment(\.colorTheme) private var colorTheme
    @Environment(\.isGradation) private var isGradation

    private let isActive: Bool

    public init(isActive: Bool) {
        self.isActive = isActive
    }

    public func body(content: Content) -> some View {
        if isGradation.wrappedValue {
            content.background(
                isActive
                    ? colorTheme.wrappedValue.color.gradient
                    : Color.clear.gradient
            )
        } else {
            content.background(
                isActive
                    ? colorTheme.wrappedValue.color
                    : .clear
            )
        }
    }
}

public struct ToolBarBackgroundModifier: ViewModifier {
    @Environment(\.colorTheme) private var colorTheme
    @Environment(\.isGradation) private var isGradation

    public init() {}

    public func body(content: Content) -> some View {
        if isGradation.wrappedValue {
            content
                .toolbarBackground(
                    colorTheme.wrappedValue.color.gradient,
                    for: .navigationBar
                )
                .toolbarBackground(.visible, for: .navigationBar)
        } else {
            content
                .toolbarBackground(
                    colorTheme.wrappedValue.color,
                    for: .navigationBar
                )
                .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

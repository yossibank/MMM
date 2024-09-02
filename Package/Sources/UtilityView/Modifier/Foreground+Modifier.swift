import SwiftUI

public struct ForegroundModifier: ViewModifier {
    @Environment(\.colorMode) private var colorMode

    public init() {}

    public func body(content: Content) -> some View {
        content.foregroundStyle(colorMode.wrappedValue.textColor)
    }
}

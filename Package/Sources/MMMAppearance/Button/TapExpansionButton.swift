import MMMData
import SwiftUI

public struct TapExpansionButton: ButtonStyle {
    @Environment(\.mainColor) private var mainColor

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(mainColor.wrappedValue)
            .foregroundStyle(.white)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

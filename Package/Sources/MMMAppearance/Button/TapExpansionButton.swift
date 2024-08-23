import SwiftUI

public struct TapExpansionButton: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.green)
            .foregroundStyle(.white)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

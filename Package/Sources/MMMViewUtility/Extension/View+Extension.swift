import MMMData
import SwiftUI

public extension View {
    func mmmForeground() -> some View {
        modifier(ForegroundModifier())
    }

    func mmmBackgroundView() -> some View {
        modifier(BackgroundViewModifier())
    }

    func mmmBackground(alpha: CGFloat = 1.0) -> some View {
        modifier(BackgroundModifier(alpha: alpha))
    }

    func mmmActiveBackground(isActive: Bool = true) -> some View {
        modifier(ActiveBackgroundModifier(isActive: isActive))
    }

    func toolBarBackground() -> some View {
        modifier(ToolBarBackgroundModifier())
    }
}

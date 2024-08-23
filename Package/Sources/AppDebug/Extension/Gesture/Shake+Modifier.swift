import SwiftUI

public extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        modifier(DeviceShakeViewModifier(action: action))
    }
}

struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    private let shakePublisher = NotificationCenter.default.publisher(
        for: UIDevice.deviceDidShakeNotification
    )

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(shakePublisher) { _ in
                action()
            }
    }
}

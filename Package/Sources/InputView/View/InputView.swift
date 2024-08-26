import MMMView
import MMMViewUtility
import SwiftUI

public struct InputView: View {
    @Environment(\.colorTheme) private var colorTheme
    @Environment(\.colorMode) private var colorMode

    @State private var selectedSegment = InputSegmentType.expenditure

    public init() {}

    public var body: some View {
        VStack {
            Divider()
                .frame(height: 3)
                .background(colorTheme.wrappedValue.color)

            MMMSegmentedControl(
                selectedSegment: $selectedSegment,
                configuration: .init(
                    selectedForegroundColor: colorMode.wrappedValue == .light
                        ? .black
                        : .white,
                    foregroundColor: colorMode.wrappedValue == .light
                        ? .black
                        : .white
                )
            )
            .frame(width: 280)

            switch selectedSegment {
            case .expenditure:
                Text("支出")

            case .income:
                Text("収入")
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 16)
        .mmmForeground()
        .mmmBackgroundView()
    }
}

#Preview {
    InputView()
}

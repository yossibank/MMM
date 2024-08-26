import MMMView
import MMMViewUtility
import SwiftUI

public struct InputView: View {
    @Environment(\.colorTheme) private var colorTheme
    @Environment(\.colorMode) private var colorMode

    @State private var selectedSegment = InputSegmentType.expenditure

    public init() {}

    public var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 8) {
                Divider()
                    .frame(height: 2)
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
                .frame(width: 320)

                Text(selectedSegment.title)

                Spacer()
            }
            .frame(width: proxy.size.width)
            .padding(.top, 16)
            .mmmForeground()
            .mmmBackgroundView()
        }
    }
}

#Preview {
    InputView()
}

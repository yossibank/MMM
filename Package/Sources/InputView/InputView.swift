import MMMView
import SwiftUI

public struct InputView: View {
    @State private var selectedSegment: InputSegmentType = .expenditure

    public init() {}

    public var body: some View {
        VStack(alignment: .center) {
            MMMSegmentedControl(selectedSegment: $selectedSegment)
                .frame(width: 280)

            switch selectedSegment {
            case .expenditure:
                Text("支出")

            case .income:
                Text("収入")
            }

            Spacer()
        }
        .padding(.top, 20)
    }
}

#Preview {
    InputView()
}

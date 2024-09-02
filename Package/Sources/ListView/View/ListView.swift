import SwiftUI
import UtilityView

public struct ListView: View {
    public init() {}

    public var body: some View {
        List {
            Text("一覧")
                .listRowBackground(Color.gray.opacity(0.1))
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .mmmForeground()
        .mmmBackgroundView()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("一覧")
                    .bold()
                    .foregroundStyle(.white)
            }
        }
        .toolBarBackground()
    }
}

#Preview {
    ListView()
}

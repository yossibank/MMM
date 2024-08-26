import MMMViewUtility
import SwiftUI

public struct ReportView: View {
    public init() {}

    public var body: some View {
        List {
            Text("レポート")
                .listRowBackground(Color.gray.opacity(0.1))
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .mmmForeground()
        .mmmBackgroundView()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("レポート")
                    .bold()
                    .foregroundStyle(.white)
            }
        }
        .toolBarBackground()
    }
}

#Preview {
    ReportView()
}

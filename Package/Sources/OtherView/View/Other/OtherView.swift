import MMMData
import MMMViewUtility
import SwiftUI

public struct OtherView: View {
    @Environment(\.colorTheme) private var colorTheme

    var otherRouter: OtherRouter

    public init(otherRouter: OtherRouter) {
        self.otherRouter = otherRouter
    }

    public var body: some View {
        OtherRouterView(otherRouter: otherRouter) {
            List {
                Section {
                    NavigationLink(value: OtherRoute.themeColor) {
                        Text("テーマカラー")
                    }
                } header: {
                    Text("設定")
                }
                .listRowBackground(Color.gray.opacity(0.1))
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("その他")
                        .bold()
                        .foregroundStyle(.white)
                }
            }
            .toolBarBackground()
        }
    }
}

#Preview {
    OtherView(otherRouter: OtherRouter())
}

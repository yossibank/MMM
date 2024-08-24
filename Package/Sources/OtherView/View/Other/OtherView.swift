import MMMData
import SwiftUI

public struct OtherView: View {
    @Environment(\.mainColor) private var mainColor

    @State private var router = Router()

    public init() {}

    public var body: some View {
        RouterView(router: router) {
            List {
                Section {
                    NavigationLink(value: Route.themeColor) {
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
            .toolbarBackground(mainColor.wrappedValue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    OtherView()
}

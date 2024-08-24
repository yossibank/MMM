import SwiftUI

public struct OtherView: View {
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
            }
            .listStyle(.insetGrouped)
            .navigationTitle("その他")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    OtherView()
}

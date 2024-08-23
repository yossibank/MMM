import SwiftData
import SwiftUI

struct NetworkingLogListView: View {
    @Query(
        sort: \APIModel.date,
        order: .reverse
    )
    private var models: [APIModel]

    @State private var router = Router()

    @Environment(\.modelContext) private var context

    var body: some View {
        RouterView(router: router) {
            List(models, id: \.id) { model in
                NavigationLink(value: Route.networkDetail(model)) {
                    NetworkingLogView(model: model)
                }
            }
            .listStyle(.inset)
            .navigationTitle("ログ履歴")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NetworkingLogListView()
        .modelContainer(DebugSwiftData.previewContainer)
}

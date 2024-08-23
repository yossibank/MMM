import SwiftUI

struct DevelopmentView: View {
    @State private var isShowLogView = false

    private var router = Router()

    var body: some View {
        RouterView(router: router) {
            Text("Development")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("ログ履歴") {
                            isShowLogView.toggle()
                        }
                    }
                }
                .sheet(
                    isPresented: $isShowLogView,
                    content: {
                        NetworkingLogListView()
                    }
                )
        }
    }
}

#Preview {
    DevelopmentView()
        .modelContainer(DebugSwiftData.previewContainer)
}

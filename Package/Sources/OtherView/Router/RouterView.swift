import SwiftUI

struct RouterView<Content: View>: View {
    @Environment(\.mainColor) private var mainColor

    @State private var router: Router

    private let content: Content

    init(
        router: Router,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.router = router
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Route.self) { route in
                    router.view(for: route)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text(route.title)
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                        }
                        .toolbarBackground(mainColor.wrappedValue, for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                }
        }
        .tint(.white)
        .environment(\.router, router)
    }
}

#Preview {
    RouterView(router: Router()) {
        Text("RouterView")
            .navigationTitle("Title")
            .navigationBarTitleDisplayMode(.inline)
    }
}

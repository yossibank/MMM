import SwiftUI

struct RouterView<Content: View>: View {
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
                        .navigationTitle(route.title)
                        .navigationBarTitleDisplayMode(.inline)
                }
        }
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

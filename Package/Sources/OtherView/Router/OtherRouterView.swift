import MMMViewUtility
import SwiftUI

public struct OtherRouterView<Content: View>: View {
    @Environment(\.colorTheme) private var colorTheme

    @State private var otherRouter: OtherRouter

    private let content: Content

    public init(
        otherRouter: OtherRouter,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.otherRouter = otherRouter
        self.content = content()
    }

    public var body: some View {
        NavigationStack(path: $otherRouter.path) {
            content
                .navigationDestination(for: OtherRoute.self) { route in
                    otherRouter.view(for: route)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text(route.title)
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                        }
                        .toolBarBackground()
                }
        }
        .tint(.white)
        .environment(\.otherRouter, otherRouter)
    }
}

#Preview {
    OtherRouterView(otherRouter: OtherRouter()) {
        Text("RouterView")
            .navigationTitle("Title")
            .navigationBarTitleDisplayMode(.inline)
    }
}

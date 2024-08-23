import SwiftData
import SwiftUI

public struct PreviewContainerView<Content: View>: View {
    private let container: ModelContainer
    private let content: Content

    public init(
        container: ModelContainer,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.container = container
        self.content = content()
    }

    public var body: some View {
        content
            .modelContainer(container)
    }
}

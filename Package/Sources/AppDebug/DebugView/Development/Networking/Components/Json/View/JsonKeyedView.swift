import SwiftUI

struct JsonKeyedView<Content: View>: View {
    private let key: String
    private let content: Content

    init(
        key: String,
        @ViewBuilder content: () -> Content
    ) {
        self.key = key
        self.content = content()
    }

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text("\"\(key)\"")
            Text(": ")
            content
        }
    }
}

#Preview {
    JsonKeyedView(key: "key") {
        Text("value")
    }
}

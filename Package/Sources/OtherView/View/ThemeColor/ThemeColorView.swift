import SwiftUI

struct ThemeColorView: View {
    @Environment(\.router) private var router

    var body: some View {
        Text("Theme Color")

        Button("戻る") {
            router.back()
        }
    }
}

#Preview {
    ThemeColorView()
}

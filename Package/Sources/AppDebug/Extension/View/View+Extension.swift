import SwiftUI

extension View {
    @ViewBuilder
    func jsonKey(_ key: String?) -> some View {
        if let key {
            HStack(alignment: .top, spacing: 0) {
                Text("\"\(key)\"")
                Text(": ")
                    .foregroundStyle(.gray)
                self
            }
        } else {
            self
        }
    }
}

extension View {
    @ViewBuilder
    func tabItem(_ item: DebugTabItem) -> some View {
        tabItem {
            Label(item.title, systemImage: item.systemImageName)
        }
        .tag(item.tab)
    }
}

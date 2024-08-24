import SwiftUI

struct DebugTabItem: Hashable, Sendable {
    let title: String
    let systemImageName: String
    let tab: Tab

    enum Tab: CaseIterable {
        case development
        case checklist
    }
}

extension DebugTabItem {
    static let development = DebugTabItem(
        title: "お助け開発ツール",
        systemImageName: "apple.terminal",
        tab: .development
    )

    static let checklist = DebugTabItem(
        title: "チェックリスト",
        systemImageName: "checklist",
        tab: .checklist
    )
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

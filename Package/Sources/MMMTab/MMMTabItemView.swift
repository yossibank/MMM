import ListView
import OtherView
import ReportView
import SwiftUI

public struct MMMTabItemView: View {
    let tabItem: MMMTabItem
    let tabRouter: MMMTabRouter

    public init(
        tabItem: MMMTabItem,
        tabRouter: MMMTabRouter
    ) {
        self.tabItem = tabItem
        self.tabRouter = tabRouter
    }

    public var body: some View {
        Group {
            switch tabItem {
            case .report:
                ReportView()

            case .list:
                ListView()

            case .other:
                OtherView(otherRouter: tabRouter.other)
            }
        }
        .tag(tabItem)
    }
}

#Preview {
    MMMTabItemView(
        tabItem: .report,
        tabRouter: .init(other: .init())
    )
}

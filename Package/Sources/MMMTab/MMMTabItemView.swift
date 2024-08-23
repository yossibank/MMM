import ListView
import OtherView
import ReportView
import SwiftUI

public struct MMMTabItemView: View {
    public let tabItem: MMMTabItem

    public init(tabItem: MMMTabItem) {
        self.tabItem = tabItem
    }

    public var body: some View {
        Group {
            switch tabItem {
            case .report:
                ReportView()

            case .list:
                ListView()

            case .other:
                OtherView()
            }
        }
        .tag(tabItem)
        .tint(.accentColor)
    }
}

#Preview {
    MMMTabItemView(tabItem: .report)
}

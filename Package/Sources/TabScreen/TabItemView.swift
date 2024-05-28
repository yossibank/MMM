import BillingStatementScreen
import HelpfulScreen
import OtherScreen
import ReportScreen
import SpendingIncomeInputScreen
import SwiftUI

public struct TabItemView: View {
    public let tabItem: TabItem

    public init(tabItem: TabItem) {
        self.tabItem = tabItem
    }

    public var body: some View {
        Group {
            switch tabItem {
            case .spendingIncomeInput:
                SpendingIncomeInputScreen()
            case .billingStatement:
                BillingStatementScreen()
            case .report:
                ReportScreen()
            case .helpful:
                HelpfulScreen()
            case .other:
                OtherScreen()
            }
        }
        .tabItem {
            Image(tabItem.imageResource)
            Text(tabItem.title)
        }
        .tag(tabItem)
        .tint(.accentColor)
    }
}

#Preview {
    TabItemView(tabItem: .billingStatement)
}

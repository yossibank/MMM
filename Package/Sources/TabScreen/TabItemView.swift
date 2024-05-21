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
}

#Preview {
    TabItemView(tabItem: .billingStatement)
}

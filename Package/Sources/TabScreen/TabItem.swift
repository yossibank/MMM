import SwiftUI

public enum TabItem: String, CaseIterable {
    case spendingIncomeInput
    case billingStatement
    case report
    case helpful
    case other

    public var tag: String {
        rawValue
    }

    public var title: String {
        switch self {
        case .spendingIncomeInput:
            String(localized: "spendingIncomeInput", bundle: .module)
        case .billingStatement:
            String(localized: "billingStatement", bundle: .module)
        case .report:
            String(localized: "report", bundle: .module)
        case .helpful:
            String(localized: "helpful", bundle: .module)
        case .other:
            String(localized: "other", bundle: .module)
        }
    }

    public var imageResource: ImageResource {
        switch self {
        case .spendingIncomeInput: .spendingIncomeInput
        case .billingStatement: .billingStatement
        case .report: .report
        case .helpful: .helpful
        case .other: .other
        }
    }
}

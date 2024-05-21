public enum TabItem: String, CaseIterable {
    case spendingIncomeInput
    case billingStatement
    case report
    case helpful
    case other

    public var tag: String {
        rawValue
    }

    public var iconName: String {
        switch self {
        case .spendingIncomeInput: "1.circle.fill"
        case .billingStatement: "2.circle.fill"
        case .report: "3.circle.fill"
        case .helpful: "4.circle.fill"
        case .other: "5.circle.fill"
        }
    }
}

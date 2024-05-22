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
        case .spendingIncomeInput: "収支入力"
        case .billingStatement: "明細一覧"
        case .report: "レポート"
        case .helpful: "お役立ち"
        case .other: "その他"
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

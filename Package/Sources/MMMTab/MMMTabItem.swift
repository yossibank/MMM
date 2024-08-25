import SwiftUI

public enum MMMTabItem: String, CaseIterable {
    case report
    case list
    case other

    public var tag: String {
        rawValue
    }

    public var title: String {
        switch self {
        case .report: "レポート"
        case .list: "一覧"
        case .other: "その他"
        }
    }

    public var imageResource: ImageResource {
        switch self {
        case .report: .report
        case .list: .list
        case .other: .other
        }
    }
}

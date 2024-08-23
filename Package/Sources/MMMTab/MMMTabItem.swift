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
        case .report:
            String(localized: "report", bundle: .module)

        case .list:
            String(localized: "list", bundle: .module)

        case .other:
            String(localized: "other", bundle: .module)
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

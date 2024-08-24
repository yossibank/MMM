import Foundation

enum Route: Hashable, Sendable {
    case themeColor

    var title: String {
        switch self {
        case .themeColor: "テーマカラー"
        }
    }
}

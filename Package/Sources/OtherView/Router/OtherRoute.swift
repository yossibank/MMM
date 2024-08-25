import Foundation

public enum OtherRoute: Hashable, Sendable {
    case themeColor

    public var title: String {
        switch self {
        case .themeColor: "テーマカラー"
        }
    }
}

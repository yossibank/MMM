import Foundation

enum Route: Hashable, Sendable {
    case networkList
    case networkDetail(APIModel)
    case networkBody(APIModel, BodyType)

    var title: String {
        switch self {
        case .networkList: "ログ履歴"
        case .networkDetail: "ログ詳細"
        case .networkBody: "ログ中身"
        }
    }
}

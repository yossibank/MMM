import MMMView
import SwiftUI

enum InputSegmentType: MMMSegmentTypeProtocol {
    case expenditure
    case income
    case transfer

    var id: Self { self }

    var title: String {
        switch self {
        case .expenditure: "支出"
        case .income: "収入"
        case .transfer: "振替"
        }
    }

    var tintColor: Color? {
        switch self {
        case .expenditure: .red.opacity(0.8)
        case .income: .blue.opacity(0.8)
        case .transfer: .green.opacity(0.8)
        }
    }
}

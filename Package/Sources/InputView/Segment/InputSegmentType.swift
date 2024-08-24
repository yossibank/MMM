import MMMView
import SwiftUI

enum InputSegmentType: MMMSegmentTypeProtocol {
    case expenditure
    case income

    var id: Self { self }

    var title: String {
        switch self {
        case .expenditure: String(localized: "expenditure", bundle: .module)
        case .income: String(localized: "income", bundle: .module)
        }
    }

    var tintColor: Color? {
        switch self {
        case .expenditure: .red.opacity(0.8)
        case .income: .blue.opacity(0.8)
        }
    }
}

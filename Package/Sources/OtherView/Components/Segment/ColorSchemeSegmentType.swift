import MMMView
import SwiftUI

enum ColorSchemeSegmentType: MMMSegmentTypeProtocol {
    case light
    case dark

    var id: Self { self }

    var title: String {
        switch self {
        case .light: "白背景"
        case .dark: "黒背景"
        }
    }

    var tintColor: Color? {
        switch self {
        case .light: .white
        case .dark: .black
        }
    }
}

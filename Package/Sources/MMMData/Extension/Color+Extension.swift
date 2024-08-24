import SwiftUI

public extension Color {
    var colorTheme: ColorTheme {
        switch self {
        case .red: .red
        case .yellow: .yellow
        case .blue: .blue
        case .green: .green
        case .orange: .orange
        default: .green
        }
    }
}

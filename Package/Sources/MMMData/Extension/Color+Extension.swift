import SwiftUI

extension Color {
    static let random: Color = .init(
        red: .random(in: 0...1),
        green: .random(in: 0...1),
        blue: .random(in: 0...1)
    )
}

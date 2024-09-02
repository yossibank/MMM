import SwiftUI

enum CaluclatorItem: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case doubleZero = "00"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case delete = "DEL"

    var isBigWidth: Bool {
        self == .delete || self == .doubleZero
    }

    var color: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            .orange

        case .clear, .delete:
            Color(.lightGray)

        default:
            Color(
                .init(
                    red: 55 / 255,
                    green: 55 / 255,
                    blue: 55 / 255,
                    alpha: 1.0
                )
            )
        }
    }

    static let all: [[CaluclatorItem]] = [
        [.clear, .delete, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .doubleZero, .equal]
    ]
}

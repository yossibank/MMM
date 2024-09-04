import Foundation

enum CalculatorOperation {
    case add
    case subtract
    case multiply
    case divide
    case none

    var nowCaluclating: Bool {
        self != .none
    }
}

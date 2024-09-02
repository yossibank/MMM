import Foundation

enum CaluclatorOperation {
    case add
    case subtract
    case multiply
    case divide
    case none

    var nowCaluclating: Bool {
        self != .none
    }
}

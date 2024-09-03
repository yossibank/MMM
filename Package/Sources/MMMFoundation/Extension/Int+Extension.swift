import Foundation
import Utility

public extension Int {
    var withComma: String {
        NumberFormatter.format.string(from: .init(integerLiteral: self)) ?? "\(self)"
    }
}

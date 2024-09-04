import Foundation

public extension Date {
    var beforeDay: Date {
        Self.calendar.date(byAdding: .day, value: -1, to: self) ?? .init()
    }

    var afterDay: Date {
        Self.calendar.date(byAdding: .day, value: 1, to: self) ?? .init()
    }
}

private extension Date {
    static let calendar = Calendar(identifier: .gregorian)
}

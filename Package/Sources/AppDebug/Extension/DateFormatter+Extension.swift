import Foundation

extension DateFormatter {
    static let logFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd(E) HH:mm:ss.SSS"
        formatter.locale = .init(identifier: "ja_JP")
        formatter.calendar = .init(identifier: .gregorian)
        return formatter
    }()
}

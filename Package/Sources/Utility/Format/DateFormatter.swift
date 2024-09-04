import Foundation

public extension DateFormatter {
    static func format(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy年M月d日(E)"
        return dateFormatter.string(from: date)
    }
}

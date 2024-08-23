import Foundation

extension Date {
    func timeDifference(date: Date) -> String {
        let difference = Int(timeIntervalSince(date))
        let hours = difference / 3600
        let minutes = (difference % 3600) / 60
        let seconds = difference % 60

        if hours > 0 {
            return "\(hours)時間\(minutes)分\(seconds)秒前"
        }

        if minutes > 0 {
            return "\(minutes)分\(seconds)秒前"
        }

        return "\(seconds)秒前"
    }
}

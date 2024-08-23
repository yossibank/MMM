import OSLog
import SwiftUI

extension OSLogEntryLog.Level {
    var color: Color {
        switch self {
        case .undefined: .blue
        case .debug: .green
        case .info: .purple
        case .notice: .orange
        case .error: .yellow
        case .fault: .red
        @unknown default: .clear
        }
    }
}

import SwiftUI

public enum LogCategory: String, Codable, CaseIterable, Sendable {
    case networking

    var color: Color {
        switch self {
        case .networking: .purple
        }
    }

    var title: String {
        switch self {
        case .networking: "Networking"
        }
    }
}

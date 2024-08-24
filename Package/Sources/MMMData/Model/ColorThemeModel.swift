import Foundation
import SwiftData
import SwiftUI

@Model
public final class ColorThemeModel: @unchecked Sendable {
    @Attribute(.unique)
    public var id: String
    public var colorTheme: ColorTheme

    public init(
        id: String = ColorThemeModel.themeColorKey,
        colorTheme: ColorTheme
    ) {
        self.id = id
        self.colorTheme = colorTheme
    }

    public static let themeColorKey = "ThemeColorKey"
    public static let defaultModel = ColorThemeModel(colorTheme: .green)
}

public enum ColorTheme: String, Codable, CaseIterable, Sendable {
    case red
    case yellow
    case blue
    case green
    case orange

    public var color: Color {
        switch self {
        case .red: .red
        case .yellow: .yellow
        case .blue: .blue
        case .green: .green
        case .orange: .orange
        }
    }
}

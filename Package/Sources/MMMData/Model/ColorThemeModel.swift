import Foundation
import SwiftData
import SwiftUI

@Model
public final class ColorThemeModel: @unchecked Sendable {
    @Attribute(.unique)
    public var id: String
    public var colorTheme: ColorTheme
    public var colorMode: ColorMode
    public var isGradation: Bool

    public init(
        id: String,
        colorTheme: ColorTheme,
        colorMode: ColorMode,
        isGradation: Bool
    ) {
        self.id = id
        self.colorTheme = colorTheme
        self.colorMode = colorMode
        self.isGradation = isGradation
    }

    public static let defaultModel = ColorThemeModel(
        id: "ThemeColorKey",
        colorTheme: .green,
        colorMode: .light,
        isGradation: false
    )
}

public enum ColorTheme: Codable, CaseIterable, Sendable {
    case red
    case orange
    case yellow
    case green
    case mint
    case teal
    case cyan
    case blue
    case indigo
    case pink
    case brown
    case gray
    case black
    case random

    public var color: Color {
        switch self {
        case .red: .red
        case .orange: .orange
        case .yellow: .yellow
        case .green: .green
        case .mint: .mint
        case .teal: .teal
        case .cyan: .cyan
        case .blue: .blue
        case .indigo: .indigo
        case .pink: .pink
        case .brown: .brown
        case .gray: .gray
        case .black: .black
        case .random: .random
        }
    }

    public var title: String {
        switch self {
        case .red: "レッド"
        case .orange: "オレンジ"
        case .yellow: "イエロー"
        case .green: "グリーン"
        case .mint: "ミント"
        case .teal: "ティール"
        case .cyan: "シアン"
        case .blue: "ブルー"
        case .indigo: "インディゴ"
        case .pink: "ピンク"
        case .brown: "ブラウン"
        case .gray: "グレー"
        case .black: "ブラック"
        case .random: "ランダム(起動毎に変更)"
        }
    }
}

public enum ColorMode: Codable, Sendable {
    case light
    case dark

    public var bgColor: Color {
        switch self {
        case .light: .white
        case .dark: .black
        }
    }

    public var textColor: Color {
        switch self {
        case .light: .black
        case .dark: .white
        }
    }
}

import SwiftUI

public enum AppIconType {
    case debug
    case adhoc
    case release

    public var iconTitle: String {
        switch self {
        case .debug: "Debug"
        case .adhoc: "AdHoc"
        case .release: ""
        }
    }

    public var iconColor: Color {
        switch self {
        case .debug: .green
        case .adhoc: .orange
        case .release: .clear
        }
    }

    public var isShowIcon: Bool {
        self != .release
    }
}

public struct AppIconView: View {
    private let iconName: String
    private let iconColor: Color
    private let iconType: AppIconType

    public init(
        iconName: String,
        iconColor: Color,
        iconType: AppIconType
    ) {
        self.iconName = iconName
        self.iconColor = iconColor
        self.iconType = iconType
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(iconColor.gradient)

                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .padding(geometry.size.width * 0.16)

                if iconType.isShowIcon {
                    Text(iconType.iconTitle)
                        .font(.system(size: 80, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .frame(width: geometry.size.width)
                        .background(iconType.iconColor)
                }
            }
        }
    }
}

#Preview {
    VStack {
        AppIconView(
            iconName: "m.square.fill",
            iconColor: .black,
            iconType: .debug
        )
        .frame(width: 300, height: 300)

        AppIconView(
            iconName: "m.square",
            iconColor: .black,
            iconType: .adhoc
        )
        .frame(width: 300, height: 300)
    }
}

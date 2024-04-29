import SwiftUI

public struct AppIconView: View {
    private let iconName: String
    private let iconColor: Color

    public init(
        iconName: String,
        iconColor: Color
    ) {
        self.iconName = iconName
        self.iconColor = iconColor
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(iconColor.gradient)

                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .padding(geometry.size.width * 0.15)
            }
        }
    }
}

#Preview {
    VStack {
        AppIconView(
            iconName: "m.square.fill",
            iconColor: .black
        )
        .frame(width: 300, height: 300)

        AppIconView(
            iconName: "m.square",
            iconColor: .black
        )
        .frame(width: 300, height: 300)
    }
}

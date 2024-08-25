import MMMData
import MMMView
import SwiftUI

struct ThemeColorView: View {
    @Environment(\.mainColor) private var mainColor
    @Environment(\.colorMode) private var colorMode

    @State private var colorScheme: ColorSchemeSegmentType = .light
    @State private var colorAlpha: CGFloat = 1.0

    private let dataModel = MMMDataModel<ColorThemeModel>()

    var body: some View {
        List {
            Section {
                ForEach(ColorTheme.allCases, id: \.self) { colorTheme in
                    HStack(spacing: 16) {
                        Circle()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(colorTheme.color)

                        Text(colorTheme.title)

                        Spacer()

                        if colorTheme.color == mainColor.wrappedValue {
                            Text("チェック")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        updateColorTheme(colorTheme)
                    }
                }
            } header: {
                Text("メインカラー")
            }
            .listRowBackground(Color.gray.opacity(0.1))

            Section {
                VStack {
                    MMMSegmentedControl(
                        selectedSegment: $colorScheme,
                        configuration: .init(
                            selectedForegroundColor: colorScheme == .light ? .black : .white,
                            foregroundColor: colorScheme == .light ? .black : .white
                        )
                    )
                    .onChange(of: colorScheme) { _, newValue in
                        updateColorMode(newValue == .light ? .light : .dark)
                    }
                }
            } header: {
                Text("背景カラー")
            }
            .listRowBackground(Color.gray.opacity(0.1))
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .foregroundStyle(colorMode.wrappedValue.textColor)
        .background(colorMode.wrappedValue.bgColor)
        .onAppear {
            if let model = dataModel.first {
                colorScheme = model.colorMode == .light ? .light : .dark
            }
        }
    }

    @MainActor
    private func updateColorTheme(_ theme: ColorTheme) {
        let model = dataModel.first ?? .defaultModel
        model.colorTheme = theme
        dataModel.upsert(model: model)
        mainColor.wrappedValue = theme.color
    }

    @MainActor
    private func updateColorMode(_ mode: ColorMode) {
        let model = dataModel.first ?? .defaultModel
        model.colorMode = mode
        dataModel.upsert(model: model)
        colorMode.wrappedValue = mode
    }
}

#Preview {
    ThemeColorView()
        .modelContainer(MMMDataModelConfiguration.container)
}

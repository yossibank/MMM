import MMMData
import MMMView
import MMMViewUtility
import SwiftUI
import UIKit

struct ThemeColorView: View {
    @Environment(\.colorTheme) private var colorTheme
    @Environment(\.colorMode) private var colorMode
    @Environment(\.isGradation) private var isGradation

    @State private var colorScheme: ColorSchemeSegmentType = .light
    @State private var colorAlpha: CGFloat = 1.0

    private let dataModel = MMMDataModel<ColorThemeModel>()

    var body: some View {
        List {
            Section {
                ForEach(ColorTheme.allCases, id: \.self) { theme in
                    HStack(spacing: 16) {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(theme.color)

                        Text(theme.title)

                        Spacer()

                        if theme == colorTheme.wrappedValue {
                            Image(.checkmark)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        updateColorTheme(theme)
                    }
                }
            } header: {
                Text("メインカラー")
            }
            .listRowBackground(Color.gray.opacity(0.1))

            Section {
                HStack {
                    Text("グラデーションあり")

                    Spacer()

                    Toggle("", isOn: isGradation)
                        .labelsHidden()
                        .tint(.green)
                        .onChange(of: isGradation.wrappedValue) { _, newValue in
                            updateIsGradation(newValue)
                        }
                }
            } header: {
                Text("グラデーションカラー")
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
        .mmmForeground()
        .mmmBackgroundView()
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
        colorTheme.wrappedValue = theme
    }

    @MainActor
    private func updateColorMode(_ mode: ColorMode) {
        let model = dataModel.first ?? .defaultModel
        model.colorMode = mode
        dataModel.upsert(model: model)
        colorMode.wrappedValue = mode
    }

    @MainActor
    private func updateIsGradation(_ isOn: Bool) {
        let model = dataModel.first ?? .defaultModel
        model.isGradation = isOn
        dataModel.upsert(model: model)
        isGradation.wrappedValue = isOn
    }
}

#Preview {
    ThemeColorView()
        .modelContainer(MMMDataModelConfiguration.container)
}

import MMMData
import SwiftUI

struct ThemeColorView: View {
    @Environment(\.mainColor) private var mainColor
    @Environment(\.otherRouter) private var otherRouter

    private let dataModel = MMMDataModel<ColorThemeModel>()

    var body: some View {
        VStack {
            Text("Theme Color")

            Button("テーマカラー変更(赤)") {
                let model = dataModel.first ?? ColorThemeModel.defaultModel
                model.colorTheme = .red
                dataModel.upsert(model: model)
                mainColor.wrappedValue = .red
            }
            .foregroundStyle(.red)

            Button("テーマカラー変更(青)") {
                let model = dataModel.first ?? ColorThemeModel.defaultModel
                model.colorTheme = .blue
                dataModel.upsert(model: model)
                mainColor.wrappedValue = .blue
            }
            .foregroundStyle(.blue)

            Button("戻る") {
                otherRouter.popToRoot()
            }
            .foregroundStyle(.yellow)
        }
    }
}

#Preview {
    ThemeColorView()
}

import MMMData
import SwiftUI

struct ThemeColorView: View {
    @Environment(\.router) private var router
    @Environment(\.mainColor) private var mainColor

    private let dataModel = MMMDataModel<ColorThemeModel>()

    var body: some View {
        Text("Theme Color")

        Button("テーマカラー変更(赤)") {
            let model = dataModel.first ?? ColorThemeModel.defaultModel
            model.colorTheme = .red
            dataModel.upsert(model: model)
            mainColor.wrappedValue = .red
        }

        Button("テーマカラー変更(青)") {
            let model = dataModel.first ?? ColorThemeModel.defaultModel
            model.colorTheme = .blue
            dataModel.upsert(model: model)
            mainColor.wrappedValue = .blue
        }
    }
}

#Preview {
    ThemeColorView()
}

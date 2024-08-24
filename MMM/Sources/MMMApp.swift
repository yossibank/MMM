import AppDebug
import MMMAppearance
import MMMData
import MMMTab
import SwiftData
import SwiftUI

@main
struct MMMApp: App {
    @State private var mainColor = Color.green
    @State private var isShowDebugView = false

    private let dataModel = MMMDataModel<ColorThemeModel>()

    var body: some Scene {
        WindowGroup {
            MMMTabView()
                .onAppear {
                    if let model = dataModel.first {
                        mainColor = model.colorTheme.color
                    }
                }
                .onShake {
                    isShowDebugView.toggle()
                }
                .sheet(
                    isPresented: $isShowDebugView,
                    content: {
                        DebugView()
                    }
                )
                .environment(\.mainColor, $mainColor)
        }
        .modelContainer(MMMDataModelConfiguration.container)
    }
}

import AppDebug
import MMMData
import MMMTab
import SwiftData
import SwiftUI

@main
struct MMMApp: App {
    @State private var colorTheme = ColorTheme.green
    @State private var colorMode = ColorMode.light
    @State private var isGradation = false
    @State private var isShowDebugView = false

    private let dataModel = MMMDataModel<ColorThemeModel>()

    var body: some Scene {
        WindowGroup {
            MMMTabView()
                .onAppear {
                    if let model = dataModel.first {
                        colorTheme = model.colorTheme
                        colorMode = model.colorMode
                        isGradation = model.isGradation
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
                .environment(\.isGradation, $isGradation)
                .environment(\.colorTheme, $colorTheme)
                .environment(\.colorMode, $colorMode)
        }
        .modelContainer(MMMDataModelConfiguration.container)
    }
}

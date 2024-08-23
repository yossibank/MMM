import AppDebug
import MMMAppearance
import MMMTab
import SwiftUI

@main
struct MMMApp: App {
    @State private var isShowDebugView = false

    var body: some Scene {
        WindowGroup {
            MMMTabView()
                .onShake {
                    isShowDebugView.toggle()
                }
                .sheet(
                    isPresented: $isShowDebugView,
                    content: {
                        DebugView()
                    }
                )
        }
        .debugContainer()
    }
}

private extension Scene {
    @MainActor
    func debugContainer() -> some Scene {
        #if DEBUG
            modelContainer(DebugSwiftData.container)
        #else
            self
        #endif
    }
}

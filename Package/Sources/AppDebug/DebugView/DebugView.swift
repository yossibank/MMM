import SwiftUI

public struct DebugView: View {
    public init() {}

    public var body: some View {
        TabView {
            DevelopmentView()
                .tabItem(.development)

            ChecklistView()
                .tabItem(.checklist)
        }
        .tint(.black)
    }
}

#Preview {
    DebugView()
}

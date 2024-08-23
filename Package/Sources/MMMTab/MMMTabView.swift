import SwiftUI

public struct MMMTabView: View {
    @State private var selection: MMMTabItem = .report

    public init() {}

    public var body: some View {
        TabView(selection: $selection) {
            ForEach(MMMTabItem.allCases, id: \.self) { tabItem in
                MMMTabItemView(tabItem: tabItem)
            }
        }
    }
}

#Preview {
    MMMTabView()
}

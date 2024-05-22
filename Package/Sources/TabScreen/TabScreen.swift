import SwiftUI

public struct TabScreen: View {
    @State private var selection: TabItem = .spendingIncomeInput

    public init() {}

    public var body: some View {
        TabView(selection: $selection) {
            ForEach(TabItem.allCases, id: \.self) { tabItem in
                TabItemView(tabItem: tabItem)
            }
        }
    }
}

#Preview {
    TabScreen()
}

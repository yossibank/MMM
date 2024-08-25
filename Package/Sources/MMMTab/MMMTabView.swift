import InputView
import MMMData
import MMMViewUtility
import OtherView
import SwiftUI

public struct MMMTabView: View {
    @Environment(\.colorTheme) private var colorTheme

    @State private var selection = MMMTabItem.report
    @State private var tabRouter = MMMTabRouter(other: .init())
    @State private var isTappedPlusButton = false

    public init() {
        Appearance.configure()
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                ForEach(MMMTabItem.allCases, id: \.self) { tabItem in
                    MMMTabItemView(
                        tabItem: tabItem,
                        tabRouter: tabRouter
                    )
                }
            }

            HStack(spacing: 16) {
                ZStack {
                    HStack {
                        ForEach(MMMTabItem.allCases, id: \.self) { tabItem in
                            Button {
                                if selection == tabItem {
                                    switch tabItem {
                                    case .report, .list:
                                        break

                                    case .other:
                                        tabRouter.other.popToRoot()
                                    }
                                }

                                selection = tabItem
                            } label: {
                                TabItemView(
                                    tabItem: tabItem,
                                    isActive: selection == tabItem
                                )
                            }
                        }
                    }
                }
                .frame(height: 48)
                .mmmBackground(alpha: 0.5)
                .clipShape(.rect(cornerRadius: 8))
                .padding(.vertical, 8)

                Button {
                    isTappedPlusButton.toggle()
                } label: {
                    Image(.plus)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(TapExpansionButton())
            }
        }
        .sheet(
            isPresented: $isTappedPlusButton,
            content: {
                InputView()
                    .presentationDetents([.fraction(0.75), .large])
                    .presentationDragIndicator(.visible)
            }
        )
    }

    private struct TabItemView: View {
        @Environment(\.colorTheme) private var colorTheme

        let tabItem: MMMTabItem
        let isActive: Bool

        var body: some View {
            HStack {
                Image(tabItem.imageResource)
                    .resizable()
                    .frame(width: 20, height: 20)

                if isActive {
                    Text(tabItem.title)
                        .bold()
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
            }
            .frame(width: isActive ? 120 : 60, height: 36)
            .mmmActiveBackground(isActive: isActive)
            .clipShape(.rect(cornerRadius: 8))
            .padding(.horizontal, 4)
        }
    }
}

#Preview {
    MMMTabView()
}

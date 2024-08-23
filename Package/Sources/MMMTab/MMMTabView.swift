import MMMAppearance
import SwiftUI

public struct MMMTabView: View {
    @State private var selection: MMMTabItem = .report

    public init() {
        Appearance.configure()
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                ForEach(MMMTabItem.allCases, id: \.self) { tabItem in
                    MMMTabItemView(tabItem: tabItem)
                }
            }

            HStack(spacing: 16) {
                ZStack {
                    HStack {
                        ForEach(MMMTabItem.allCases, id: \.self) { tabItem in
                            Button {
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
                .background(.green.opacity(0.5))
                .clipShape(.rect(cornerRadius: 8))
                .padding(.vertical)

                Button {} label: {
                    Image(.plus)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(TapExpansionButton())
            }
        }
    }

    private struct TabItemView: View {
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
                        .foregroundStyle(.black)
                }
            }
            .frame(width: isActive ? 120 : 60, height: 36)
            .background(isActive ? .green : .clear)
            .clipShape(.rect(cornerRadius: 8))
            .padding(.horizontal, 4)
        }
    }
}

#Preview {
    MMMTabView()
}

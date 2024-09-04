import MMMData
import SwiftUI

public struct CalendarView: View {
    @Binding private var date: Date

    @Environment(\.colorTheme) private var colorTheme
    @Environment(\.colorMode) private var colorMode

    private let didTapCloseButton: () -> Void

    public init(
        date: Binding<Date>,
        didTapCloseButton: @escaping () -> Void
    ) {
        self._date = date
        self.didTapCloseButton = didTapCloseButton
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    didTapCloseButton()
                } label: {
                    HStack(spacing: 4) {
                        Text("閉じる")
                            .font(.headline)
                            .foregroundStyle(colorMode.wrappedValue.textColor)

                        Image(.close)
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }

                Spacer()

                Button {
                    date = .init()
                } label: {
                    HStack(spacing: 4) {
                        Image(.calendar)
                            .resizable()
                            .frame(width: 24, height: 24)

                        Text("今日")
                            .font(.headline)
                            .foregroundStyle(colorMode.wrappedValue.textColor)
                    }
                }
            }
            .padding(.horizontal)

            Divider()
                .frame(height: 2)
                .background(colorTheme.wrappedValue.color)
                .padding(.top, 8)

            DatePicker(
                "",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .environment(\.locale, .init(identifier: "ja_JP"))
        }
    }
}

#Preview {
    struct PreviewView: View {
        @State private var date = Date()

        var body: some View {
            CalendarView(date: $date) {}
        }
    }

    return PreviewView()
}

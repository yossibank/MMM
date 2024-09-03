import MMMData
import SwiftUI
import Utility

public struct CalculatorView: View {
    @Binding private var value: String

    @Environment(\.colorTheme) private var colorTheme

    @State private var tempOperation: CalculatorOperation = .none
    @State private var nowOperation: CalculatorOperation = .none
    @State private var firstNumber = 0
    @State private var secondNumber = 0

    private let didTapOKButton: () -> Void

    public init(
        value: Binding<String>,
        didTapOKButton: @escaping () -> Void
    ) {
        self._value = value
        self.didTapOKButton = didTapOKButton
    }

    public var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()

                HStack {
                    Spacer()

                    Text(value)
                        .bold()
                        .font(.title2)
                        .foregroundStyle(.white)
                }
                .padding(.top, 8)
                .padding(.trailing, 16)

                Divider()
                    .frame(height: 2)
                    .background(colorTheme.wrappedValue.color)

                ForEach(CalculatorItem.all, id: \.self) { items in
                    HStack(spacing: 12) {
                        ForEach(items, id: \.self) { item in
                            Button {
                                if item == .equal {
                                    nowOperation == .none
                                        ? didTapOKButton()
                                        : didTap(item: item)
                                } else {
                                    didTap(item: item)
                                }
                            } label: {
                                Text(itemTitle(item: item))
                                    .bold()
                                    .font(.title)
                                    .frame(
                                        width: itemWidth(proxy: proxy, item: item),
                                        height: itemHeight(proxy: proxy)
                                    )
                                    .background(backgroundColor(item: item))
                                    .foregroundStyle(foregroundColor(item: item))
                                    .clipShape(.rect(cornerRadius: 20))
                            }
                        }
                    }
                }
            }
            .background(.black)
        }
    }

    private func didTap(item: CalculatorItem) {
        switch item {
        case .clear:
            value = "0"
            firstNumber = 0
            secondNumber = 0
            tempOperation = .none
            nowOperation = .none

        case .delete:
            guard value != "0" else {
                return
            }

            guard value.count != 1 else {
                value = "0"
                return
            }

            value = String(value.dropLast())

            if nowOperation.nowCaluclating {
                secondNumber = Int(value).unwrapped
            } else {
                firstNumber = Int(value).unwrapped
            }

        case .divide:
            tempOperation = .divide
            nowOperation = .divide

        case .mutliply:
            tempOperation = .multiply
            nowOperation = .multiply

        case .subtract:
            tempOperation = .subtract
            nowOperation = .subtract

        case .add:
            tempOperation = .add
            nowOperation = .add

        case .equal:
            switch nowOperation {
            case .add:
                value = String(firstNumber + secondNumber)

            case .subtract:
                value = String(firstNumber - secondNumber)

            case .multiply:
                value = String(firstNumber * secondNumber)

            case .divide:
                value = String(firstNumber / secondNumber)

            case .none:
                break
            }

            firstNumber = Int(value).unwrapped
            tempOperation = .none
            nowOperation = .none

        default:
            value.removeAll { String($0) == .comma }

            let number = item.rawValue

            if nowOperation.nowCaluclating {
                let persistedValue = tempOperation == .none ? value : ""
                value = persistedValue
                value = "\(persistedValue)\(number)"
                secondNumber = Int(value).unwrapped
            } else {
                if value == "0" {
                    value = number
                    firstNumber = Int(value).unwrapped
                } else {
                    value = "\(value)\(number)"
                    firstNumber = Int(value).unwrapped
                }
            }

            tempOperation = .none
        }
    }

    private func backgroundColor(item: CalculatorItem) -> Color {
        switch item {
        case .add:
            tempOperation == .add ? .white : .orange

        case .subtract:
            tempOperation == .subtract ? .white : .orange

        case .mutliply:
            tempOperation == .multiply ? .white : .orange

        case .divide:
            tempOperation == .divide ? .white : .orange

        default:
            item.color
        }
    }

    private func foregroundColor(item: CalculatorItem) -> Color {
        switch item {
        case .add:
            tempOperation == .add ? .orange : .white

        case .subtract:
            tempOperation == .subtract ? .orange : .white

        case .mutliply:
            tempOperation == .multiply ? .orange : .white

        case .divide:
            tempOperation == .divide ? .orange : .white

        default:
            .white
        }
    }

    private func itemTitle(item: CalculatorItem) -> String {
        if item == .equal {
            nowOperation == .none ? "OK" : item.rawValue
        } else {
            item.rawValue
        }
    }

    private func itemWidth(proxy: GeometryProxy, item: CalculatorItem) -> CGFloat {
        if item.isBigWidth {
            (proxy.size.width - 36) / 2
        } else {
            (proxy.size.width - 60) / 4
        }
    }

    private func itemHeight(proxy: GeometryProxy) -> CGFloat {
        (proxy.size.width - 72) / 6
    }
}

#Preview {
    struct PreviewView: View {
        @State private var value = "0"

        var body: some View {
            CalculatorView(value: $value) {}
        }
    }

    return PreviewView()
}

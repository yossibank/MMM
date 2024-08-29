import SwiftUI

public struct CaluclatorView: View {
    @Binding var value: String

    @State var currentOperation: CaluclatorOperation = .none
    @State var runningNumber = 0

    let buttons: [[CaluclatorButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .doubleZero, .decimal, .equal]
    ]

    public init(value: Binding<String>) {
        self._value = value
    }

    public var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                // Text display
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                .padding()

                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: buttonWidth(item: item),
                                        height: buttonHeight()
                                    )
                                    .background(item.color)
                                    .foregroundColor(.white)
                                    .cornerRadius(buttonWidth(item: item) / 2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }

    func didTap(button: CaluclatorButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide, .equal:
            if button == .add {
                currentOperation = .add
                runningNumber = Int(value) ?? 0
            } else if button == .subtract {
                currentOperation = .subtract
                runningNumber = Int(value) ?? 0
            } else if button == .mutliply {
                currentOperation = .multiply
                runningNumber = Int(value) ?? 0
            } else if button == .divide {
                currentOperation = .divide
                runningNumber = Int(value) ?? 0
            } else if button == .equal {
                let runningValue = runningNumber
                let currentValue = Int(value) ?? 0
                switch currentOperation {
                case .add: value = "\(runningValue + currentValue)"
                case .subtract: value = "\(runningValue - currentValue)"
                case .multiply: value = "\(runningValue * currentValue)"
                case .divide: value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }

            if button != .equal {
                value = "0"
            }
        case .clear:
            value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if value == "0" {
                value = number
            } else {
                value = "\(value)\(number)"
            }
        }
    }

    func buttonWidth(item: CaluclatorButton) -> CGFloat {
        (UIScreen.main.bounds.width - (5 * 12)) / 4
    }

    func buttonHeight() -> CGFloat {
        (UIScreen.main.bounds.width - (5 * 12)) / 8
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CaluclatorView(value: .constant("0"))
    }
}

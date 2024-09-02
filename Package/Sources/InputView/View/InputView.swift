import MMMView
import SwiftUI
import SwiftUIIntrospect
import UtilityView

public struct InputView: View {
    enum FocusField {
        case itemName
        case amount
    }

    @Environment(\.colorTheme) private var colorTheme
    @Environment(\.colorMode) private var colorMode
    @Environment(\.dismiss) private var dismiss

    @State private var selectedSegment = InputSegmentType.expenditure
    @State private var itemName = ""
    @State private var amountValue = "0"
    @State private var isShowCalculator = false

    @FocusState private var focusField: FocusField?

    @Binding private var isDimissDisabled: Bool

    public init(isDimissDisabled: Binding<Bool>) {
        self._isDimissDisabled = isDimissDisabled
    }

    public var body: some View {
        NavigationStack {
            VStack {
                Divider()
                    .frame(height: 2)
                    .background(colorTheme.wrappedValue.color)

                ScrollView {
                    VStack(spacing: 16) {
                        HStack {
                            Text("項目名")
                                .font(.headline)
                                .frame(width: 60, alignment: .center)

                            VStack(spacing: 0) {
                                TextField("", text: $itemName)
                                    .padding(8)
                                    .focused($focusField, equals: .itemName)
                                    .onTapGesture {
                                        withAnimation {
                                            isShowCalculator = false
                                            focusField = .itemName
                                        }
                                    }

                                Divider()
                                    .frame(height: 1)
                                    .background(colorMode.wrappedValue.textColor)
                            }
                        }
                        .padding(.trailing, 24)

                        HStack {
                            Text(selectedSegment.title)
                                .font(.headline)
                                .frame(width: 60, alignment: .center)

                            VStack(spacing: 0) {
                                TextField("", text: $amountValue)
                                    .padding(8)
                                    .focused($focusField, equals: .amount)
                                    .onTapGesture {
                                        withAnimation {
                                            isShowCalculator = true
                                            focusField = .amount
                                        }
                                    }
                                    .introspect(.textField, on: .iOS(.v17, .v18)) { textField in
                                        textField.inputView = .init()
                                    }

                                Divider()
                                    .frame(height: 1)
                                    .background(colorMode.wrappedValue.textColor)
                            }

                            Text("円")
                                .font(.headline)
                        }
                    }
                    .padding([.top, .leading, .trailing], 16)
                }

                if isShowCalculator {
                    CaluclatorView(value: $amountValue)
                        .frame(height: 360)
                        .transition(
                            .asymmetric(
                                insertion: .push(from: .bottom),
                                removal: .push(from: .top)
                            )
                        )
                }
            }
            .mmmForeground()
            .mmmBackgroundView()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image(.close)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }

                ToolbarItem(placement: .principal) {
                    MMMSegmentedControl(
                        selectedSegment: $selectedSegment,
                        configuration: .init(
                            selectedForegroundColor: colorMode.wrappedValue == .light
                                ? .black
                                : .white,
                            foregroundColor: colorMode.wrappedValue == .light
                                ? .black
                                : .white
                        )
                    )
                    .frame(width: 280)
                }

                ToolbarItem(placement: .primaryAction) {
                    Button {} label: {
                        Image(.done)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .toolbarBackground(
                colorMode.wrappedValue.bgColor,
                for: .navigationBar
            )
            .toolbarBackground(
                .visible,
                for: .navigationBar
            )
            .onTapGesture {
                withAnimation {
                    isShowCalculator = false
                    focusField = nil
                }
            }
            .onChange(of: amountValue) { _, _ in
                isDimissDisabled = amountValue != String(0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        InputView(isDimissDisabled: .constant(true))
    }
}

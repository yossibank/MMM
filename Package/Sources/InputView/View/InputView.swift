import MMMFoundation
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
    @State private var itemDate = Date()
    @State private var itemName = ""
    @State private var itemPrice = "0"
    @State private var isShowCalendar = false
    @State private var isShowCalculator = false

    @FocusState private var focusField: FocusField?

    @Binding private var isDimissDisabled: Bool

    public init(isDimissDisabled: Binding<Bool>) {
        self._isDimissDisabled = isDimissDisabled
    }

    public var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                GeometryReader { proxy in
                    VStack {
                        Divider()
                            .frame(height: 2)
                            .background(colorTheme.wrappedValue.color)

                        ScrollView {
                            VStack(spacing: 16) {
                                HStack {
                                    Text("日付")
                                        .font(.headline)
                                        .frame(width: 60, alignment: .center)

                                    VStack(spacing: 0) {
                                        HStack(alignment: .bottom) {
                                            Button("←前日") {
                                                itemDate = itemDate.beforeDay
                                            }
                                            .foregroundStyle(.black.opacity(0.6))
                                            .font(.caption)
                                            .padding(.bottom, 4)

                                            Spacer()

                                            Button {
                                                withAnimation {
                                                    isShowCalendar = true
                                                    isShowCalculator = false
                                                    focusField = nil
                                                }
                                            } label: {
                                                Text(DateFormatter.format(itemDate))
                                                    .padding(8)
                                            }

                                            Spacer()

                                            Button("翌日→") {
                                                itemDate = itemDate.afterDay
                                            }
                                            .foregroundStyle(.black.opacity(0.6))
                                            .font(.caption)
                                            .padding(.bottom, 4)
                                        }

                                        Divider()
                                            .frame(height: 1)
                                            .background(colorMode.wrappedValue.textColor)
                                    }
                                }

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
                                                    isShowCalendar = false
                                                    isShowCalculator = false
                                                    focusField = .itemName
                                                }
                                            }

                                        Divider()
                                            .frame(height: 1)
                                            .background(colorMode.wrappedValue.textColor)
                                    }
                                }

                                HStack {
                                    Text(selectedSegment.title)
                                        .font(.headline)
                                        .frame(width: 60, alignment: .center)

                                    VStack(spacing: 0) {
                                        TextField("", text: $itemPrice)
                                            .padding(8)
                                            .focused($focusField, equals: .amount)
                                            .onTapGesture {
                                                withAnimation {
                                                    isShowCalendar = false
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
                            CalculatorView(value: $itemPrice) {
                                withAnimation {
                                    isShowCalculator = false
                                    focusField = nil
                                }
                            }
                            .frame(height: proxy.size.width - 24)
                            .transition(
                                .asymmetric(
                                    insertion: .push(from: .bottom),
                                    removal: .push(from: .top)
                                )
                            )
                        }
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
                        isShowCalendar = false
                        isShowCalculator = false
                        focusField = nil
                    }
                }
                .onChange(of: itemPrice) { _, _ in
                    isDimissDisabled = itemPrice != String(0)

                    itemPrice.removeAll { String($0) == .comma }

                    if let value = Int(itemPrice) {
                        itemPrice = value.withComma
                    }
                }
            }

            if isShowCalendar {
                CalendarView(date: $itemDate) {
                    withAnimation {
                        isShowCalendar = false
                    }
                }
                .id(itemDate)
            }
        }
    }
}

#Preview {
    NavigationStack {
        InputView(isDimissDisabled: .constant(true))
    }
}

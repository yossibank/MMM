import SwiftUI

public struct MMMSegmentedControl<
    SegmentType: MMMSegmentTypeProtocol
>: View where SegmentType.AllCases == [SegmentType] {
    public struct Configuration {
        public var selectedForegroundColor: Color
        public var selectedBackgroundColor: Color
        public var foregroundColor: Color
        public var backgroundColor: Color

        public init(
            selectedForegroundColor: Color = .white,
            selectedBackgroundColor: Color = .black.opacity(0.75),
            foregroundColor: Color = .black,
            backgroundColor: Color = .gray.opacity(0.25)
        ) {
            self.selectedForegroundColor = selectedForegroundColor
            self.selectedBackgroundColor = selectedBackgroundColor
            self.foregroundColor = foregroundColor
            self.backgroundColor = backgroundColor
        }
    }

    @State private var selectedSegmentOffset = CGFloat.zero
    @State private var selectedSegmentWidth = CGFloat.zero
    @State private var dragOffset = CGFloat.zero

    @Binding var selectedSegment: SegmentType

    private var configuration: Configuration

    public init(
        selectedSegment: Binding<SegmentType>,
        configuration: Configuration = .init()
    ) {
        self._selectedSegment = selectedSegment
        self.configuration = configuration
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(configuration.backgroundColor)
                    .frame(height: 44)

                RoundedRectangle(cornerRadius: 12)
                    .fill(configuration.selectedBackgroundColor)
                    .frame(width: segmentWidth(width: proxy.size.width), height: 36)
                    .offset(x: selectedSegmentOffset + dragOffset)
                    .animation(.spring(), value: selectedSegmentOffset)

                HStack(spacing: 0) {
                    ForEach(SegmentType.allCases) { segment in
                        Text(segment.title)
                            .foregroundColor(
                                isSelected(segment: segment)
                                    ? configuration.selectedForegroundColor
                                    : configuration.foregroundColor
                            )
                            .frame(width: segmentWidth(width: proxy.size.width), height: 40)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        dragOffset = value.translation.width
                                    }
                                    .onEnded { value in
                                        withAnimation(.spring) {
                                            dragSegment(
                                                dragValue: value.translation.width,
                                                width: proxy.size.width
                                            )
                                        }
                                    }
                            )
                            .onTapGesture {
                                withAnimation(.spring) {
                                    tapSegment(
                                        segment: segment,
                                        width: proxy.size.width
                                    )
                                }
                            }
                    }
                }
            }
        }
        .frame(height: 44)
    }

    private func dragSegment(
        dragValue: CGFloat,
        width: CGFloat
    ) {
        let totalCount = CGFloat(SegmentType.allCases.count)
        let totalWidth = segmentWidth(width: width) * totalCount
        let newOffset = selectedSegmentOffset + dragValue
        let segmentIndex = Int(round(newOffset / totalWidth * totalCount))
        let clampedIndex = max(0, min(Int(totalCount) - 1, segmentIndex))
        selectedSegment = SegmentType.allCases[clampedIndex]
        selectedSegmentOffset = segmentWidth(width: width) * CGFloat(clampedIndex)
        dragOffset = 0
    }

    private func tapSegment(
        segment: SegmentType,
        width: CGFloat
    ) {
        selectedSegment = segment
        selectedSegmentOffset = segmentWidth(width: width) * segmentIndex(segment: segment)
    }

    private func segmentWidth(width: CGFloat) -> CGFloat {
        width / CGFloat(SegmentType.allCases.count)
    }

    private func segmentIndex(segment: SegmentType) -> CGFloat {
        guard let index = SegmentType.allCases.firstIndex(of: segment) else {
            return 0
        }

        return CGFloat(index)
    }

    private func isSelected(segment: SegmentType) -> Bool {
        selectedSegment == segment
    }
}

#Preview {
    enum SegmentType: MMMSegmentTypeProtocol {
        case segment1
        case segment2
        case segment3

        var id: Self { self }

        var title: String {
            switch self {
            case .segment1: "Segment1"
            case .segment2: "Segment2"
            case .segment3: "Segment3"
            }
        }

        var tintColor: Color? {
            switch self {
            case .segment1: .red.opacity(0.75)
            case .segment2: .green.opacity(0.75)
            case .segment3: .blue.opacity(0.75)
            }
        }
    }

    struct Preview: View {
        @State var segmentType: SegmentType = .segment1

        var body: some View {
            MMMSegmentedControl(
                selectedSegment: $segmentType,
                configuration: .init(
                    selectedForegroundColor: .white,
                    selectedBackgroundColor: .black.opacity(0.75),
                    foregroundColor: .black,
                    backgroundColor: .gray.opacity(0.25)
                )
            )
        }
    }

    return Preview()
}

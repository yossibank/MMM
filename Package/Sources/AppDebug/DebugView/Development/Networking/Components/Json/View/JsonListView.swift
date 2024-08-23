import SwiftUI

struct JsonListView: View {
    let key: String?
    let list: [JsonElement]
    let depth: Int

    @State var isOpen = false

    @Namespace private var animation

    var body: some View {
        VStack(alignment: .leading) {
            if list.isEmpty {
                Text("[ empty list ]")
                    .foregroundStyle(.gray)
                    .jsonKey(key)
            } else {
                HStack(spacing: 2) {
                    Text("[")
                        .foregroundStyle(.gray)

                    if !isOpen {
                        Text("...")
                            .foregroundStyle(.gray)
                            .opacity(0.3)

                        Text("]")
                            .foregroundStyle(.gray)
                            .matchedGeometryEffect(id: "Close", in: animation)

                        Text("\(list.count) items")
                            .foregroundStyle(.gray)
                            .scaleEffect(0.8)
                    }
                }
                .jsonKey(key)
                .onTapGesture {
                    withAnimation {
                        isOpen.toggle()
                    }
                }

                if isOpen {
                    ForEach(list.indices, id: \.self) { index in
                        let element = list[index]

                        JsonElementView(key: nil, element: element, depth: depth)
                            .padding(.leading, 16)
                    }

                    Text("]")
                        .foregroundStyle(.gray)
                        .matchedGeometryEffect(id: "Close", in: animation)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                isOpen.toggle()
                            }
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    JsonListView(
        key: "key",
        list: [
            .string("test"),
            .int(12345),
            .num(123.45),
            .flag(false),
            .nested([
                "key1": .string("value1"),
                "key2": .string("value2"),
                "key3": .string("value3")
            ]),
            .list([
                .string("test1"),
                .string("test2"),
                .string("test3")
            ]),
            .null,
            .error("error")
        ],
        depth: 2
    )
}

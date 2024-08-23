import SwiftUI

struct JsonObjectView: View {
    let key: String?
    let obj: [String: JsonElement]
    let depth: Int

    @State var isOpen = false

    @Namespace private var animation

    var body: some View {
        VStack(alignment: .leading) {
            if obj.isEmpty {
                Text("{ empty object }")
                    .foregroundStyle(.gray)
                    .jsonKey(key)
            } else {
                HStack(spacing: 2) {
                    Text("{")
                        .foregroundStyle(.gray)

                    if !isOpen {
                        Text("...")
                            .background(.gray)
                            .opacity(0.3)

                        Text("}")
                            .foregroundStyle(.gray)
                            .matchedGeometryEffect(id: "Close", in: animation)
                    }
                }
                .jsonKey(key)
                .onTapGesture {
                    withAnimation {
                        isOpen.toggle()
                    }
                }

                if isOpen {
                    ForEach(Array(obj.keys).sorted(), id: \.self) { key in
                        let element = obj[key]!

                        JsonElementView(key: key, element: element, depth: depth)
                            .padding(.leading, 16)
                    }

                    Text("}")
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
    JsonObjectView(
        key: "key",
        obj: [
            "value1": .string("string"),
            "value2": .int(12345),
            "value3": .num(123.45),
            "value4": .flag(true),
            "value5": .nested([
                "key1": .string("value1"),
                "key2": .string("value2"),
                "key3": .string("value3")
            ]),
            "value6": .list(
                [
                    .string("test1"),
                    .string("test2"),
                    .string("test3")
                ]
            ),
            "value7": .null,
            "value8": .error("error")
        ],
        depth: 2
    )
}

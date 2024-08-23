import SwiftUI

struct JsonElementView: View {
    let key: String?
    let element: JsonElement
    let depth: Int

    var body: some View {
        VStack(alignment: .leading) {
            if case let .string(string) = element {
                JsonStringView(string: string)
                    .jsonKey(key)
            }

            if case let .int(int) = element {
                Text(int.description)
                    .foregroundStyle(.orange)
                    .jsonKey(key)
            }

            if case let .num(num) = element {
                Text(num.description)
                    .foregroundStyle(.orange)
                    .jsonKey(key)
            }

            if case let .flag(flag) = element {
                Text("\(flag ? "true" : "false")")
                    .foregroundStyle(.blue)
                    .jsonKey(key)
            }

            if case .null = element {
                Text("null")
                    .foregroundStyle(.blue)
                    .jsonKey(key)
            }

            if case let .error(body) = element {
                Text("Error!")
                    .foregroundStyle(.red)

                Text(body)
                    .foregroundStyle(.gray)
            }

            if case let .nested(obj) = element {
                JsonObjectView(
                    key: key,
                    obj: obj,
                    depth: depth + 1,
                    isOpen: depth <= 1
                )
            }

            if case let .list(list) = element {
                JsonListView(
                    key: key,
                    list: list,
                    depth: depth + 1,
                    isOpen: depth <= 1
                )
            }
        }
    }
}

#Preview {
    JsonElementView(
        key: "key",
        element: .list([
            .string("test1"),
            .string("test2"),
            .string("test3")
        ]),
        depth: 2
    )
}

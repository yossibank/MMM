import SwiftUI

struct QueryItemsView: View {
    let queryItems: [String: String?]

    private var queryItemsArray: [(key: String, value: String?)] {
        Array(queryItems).sorted(by: { $0.key < $1.key })
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(queryItemsArray, id: \.key) { queryItem in
                HStack {
                    Text(queryItem.key)
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.black.opacity(0.6))
                        .frame(maxWidth: 100, alignment: .leading)

                    Text(queryItem.value ?? "")
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.gray)
                        .lineLimit(3)
                }
            }
        }
    }
}

#Preview {
    QueryItemsView(
        queryItems: [
            "applicationId": "1032211485929725116",
            "formatVersion": "2",
            "hits": "30",
            "keyword": "からあげ",
            "page": "1"
        ]
    )
}

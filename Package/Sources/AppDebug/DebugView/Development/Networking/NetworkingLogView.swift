import SwiftUI

struct NetworkingLogView: View {
    @State private var nowDate = Date.now

    let model: APIModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Text(DateFormatter.logFormat.string(from: model.date))
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                    .frame(maxWidth: 128, alignment: .leading)

                Text(model.category.title)
                    .font(.caption2)
                    .foregroundStyle(.white)
                    .padding(.vertical, 1)
                    .padding(.horizontal, 4)
                    .background(model.category.color)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .lineLimit(1)

                Spacer()

                Text(nowDate.timeDifference(date: model.date))
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                            nowDate = .now
                        }
                    }
            }

            HStack(alignment: .center, spacing: 8) {
                HTTPMethodView(httpMethod: model.httpMethod)
                    .bold()

                Text(model.path ?? "取得失敗")
                    .opacity(0.7)
                    .font(.subheadline)
                    .bold()
            }

            HStack {
                if let contentType = model.contentType {
                    Text("content-type: \(contentType)")
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                }

                Spacer()

                StatusCodeView(statusCode: model.statusCode)
            }

            if !model.queryItems.isEmpty {
                QueryItemsView(queryItems: model.queryItems)
            }
        }
    }
}

#Preview {
    PreviewContainerView(container: DebugSwiftData.container) {
        NetworkingLogView(model: .mock)
            .padding()
    }
}

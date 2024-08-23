import SwiftUI

struct NetworkingLogDetailView: View {
    @State private var nowDate = Date.now

    let model: APIModel

    var body: some View {
        List {
            timeSectionView
            responseSectionView
            requestSectionView
        }
    }

    private var timeSectionView: some View {
        Section {
            HStack(spacing: 4) {
                Text(DateFormatter.logFormat.string(from: model.date))
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .lineLimit(1)

                Text(model.category.title)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(.vertical, 1)
                    .padding(.horizontal, 4)
                    .background(model.category.color)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .lineLimit(1)

                Spacer()

                Text(nowDate.timeDifference(date: model.date))
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                            nowDate = .now
                        }
                    }
            }
        }
    }

    private var responseSectionView: some View {
        Section {
            if let contentType = model.contentType {
                HStack(alignment: .center) {
                    Text("Content-Type")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    Text(contentType)
                        .font(.footnote)
                        .bold()
                }
            }

            HStack {
                Text("Status Code")
                    .font(.caption)
                    .foregroundStyle(.gray)

                StatusCodeView(statusCode: model.statusCode)
            }

            if let responseBody = model.responseBody {
                NavigationLink(value: Route.networkBody(model, .response)) {
                    HStack {
                        Text("Body")
                            .font(.caption)
                            .foregroundStyle(.gray)

                        Text(responseBody)
                            .font(.caption)
                            .lineLimit(2)
                    }
                }
            }
        } header: {
            Text("Response")
                .foregroundStyle(.black)
                .bold()
        }
        .textCase(nil)
    }

    private var requestSectionView: some View {
        Section {
            HStack {
                Text("Method")
                    .font(.caption)
                    .foregroundStyle(.gray)

                HTTPMethodView(httpMethod: model.httpMethod)
            }

            HStack {
                Text("Host")
                    .font(.caption)
                    .foregroundStyle(.gray)

                Text(model.host ?? "???")
                    .font(.footnote)
                    .bold()
            }

            HStack {
                Text("Path")
                    .font(.caption)
                    .foregroundStyle(.gray)

                Text(model.path ?? "???")
                    .font(.footnote)
                    .bold()
            }

            if let httpBody = model.httpBody {
                NavigationLink(value: Route.networkBody(model, .request)) {
                    HStack {
                        Text("Body")
                            .font(.caption)
                            .foregroundStyle(.gray)

                        Text(httpBody)
                            .font(.caption)
                            .lineLimit(2)
                    }
                }
            }

            if !model.queryItems.isEmpty {
                Text("Query Parameters")
                    .font(.caption)
                    .foregroundStyle(.gray)

                QueryItemsView(queryItems: model.queryItems)
            }
        } header: {
            Text("Request")
                .foregroundStyle(.black)
                .bold()
        }
        .textCase(nil)
    }
}

#Preview {
    PreviewContainerView(container: DebugSwiftData.container) {
        RouterView(router: Router()) {
            NetworkingLogDetailView(model: .mock)
        }
    }
}

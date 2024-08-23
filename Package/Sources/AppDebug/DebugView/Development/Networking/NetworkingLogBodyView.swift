import SwiftUI

enum BodyType: Sendable {
    case response
    case request
}

struct NetworkingLogBodyView: View {
    let model: APIModel
    let bodyType: BodyType

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Text("Size")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    Text(model.responseSize ?? "???")
                        .font(.callout)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)

                Divider()

                switch bodyType {
                case .response:
                    JsonView(model.responseBody ?? "")
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)

                case .request:
                    JsonView(model.httpBody ?? "")
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    PreviewContainerView(container: DebugSwiftData.container) {
        NetworkingLogBodyView(
            model: .mock,
            bodyType: .request
        )
    }
}

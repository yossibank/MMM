import SwiftUI

struct HTTPMethodView: View {
    let httpMethod: String?

    var body: some View {
        Text(httpMethod ?? "取得失敗")
            .font(.subheadline)
            .foregroundStyle(httpMethodColor())
    }

    private func httpMethodColor() -> Color {
        switch httpMethod {
        case "GET": .green
        case "POST": .blue
        case "PUT": .orange
        case "PATCH": .teal
        case "DELETE": .red
        default: .gray
        }
    }
}

#Preview {
    VStack(spacing: 8) {
        HTTPMethodView(httpMethod: "GET")
        HTTPMethodView(httpMethod: "POST")
        HTTPMethodView(httpMethod: "PUT")
        HTTPMethodView(httpMethod: "PATCH")
        HTTPMethodView(httpMethod: "DELETE")
        HTTPMethodView(httpMethod: "UNKNOWN")
    }
}

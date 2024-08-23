import SwiftUI

@Observable
final class Router: @unchecked Sendable {
    var path: [Route] = []

    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .networkList:
            NetworkingLogListView()

        case let .networkDetail(model):
            NetworkingLogDetailView(model: model)

        case let .networkBody(model, bodyType):
            NetworkingLogBodyView(model: model, bodyType: bodyType)
        }
    }

    func push(_ route: Route) {
        path.append(route)
    }

    func back() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}

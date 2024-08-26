import SwiftUI

@Observable
public final class OtherRouter: @unchecked Sendable {
    public var path: [OtherRoute] = []

    public init() {}

    @ViewBuilder public func view(for route: OtherRoute) -> some View {
        switch route {
        case .themeColor:
            ThemeColorView()
        }
    }

    public func push(_ route: OtherRoute) {
        path.append(route)
    }

    public func back() {
        path.removeLast()
    }

    public func popToRoot() {
        path.removeLast(path.count)
    }
}

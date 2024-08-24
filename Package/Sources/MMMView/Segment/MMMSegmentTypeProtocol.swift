import SwiftUI

public protocol MMMSegmentTypeProtocol: CaseIterable, Identifiable, Equatable {
    var title: String { get }
    var tintColor: Color? { get }
}

public extension MMMSegmentTypeProtocol {
    var tintColor: Color? { nil }
}

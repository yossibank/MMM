import Foundation

public extension String? {
    var unwrapped: String {
        self ?? ""
    }
}

public extension Int? {
    var unwrapped: Int {
        self ?? 0
    }
}

public extension Double? {
    var unwrapped: Double {
        self ?? 0
    }
}

public extension CGFloat? {
    var unwrapped: CGFloat {
        self ?? 0
    }
}

public extension Bool? {
    var unwrapped: Bool {
        self ?? false
    }
}

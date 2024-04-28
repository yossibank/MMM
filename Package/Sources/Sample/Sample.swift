/// @mockable
public protocol SampleClassProtocol {
    func sample() -> String
}

public final class SampleClass: SampleClassProtocol {
    public init() {}

    public func sample() -> String {
        "sample"
    }
}

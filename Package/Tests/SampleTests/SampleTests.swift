import XCTest
@testable import Sample

final class PackageTests: XCTestCase {
    func test_sample() {
        XCTAssertEqual(SampleClass.test1, "test1")
    }
}

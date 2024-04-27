import XCTest
@testable import Sample

final class SampleTests: XCTestCase {
    private var sampleClass: SampleClass!

    override func setUp() {
        super.setUp()

        sampleClass = .init()
    }

    override func tearDown() {
        super.tearDown()

        sampleClass = nil
    }

    func test_sample() {
        XCTAssertEqual(sampleClass.sample(), "sample")
    }
}

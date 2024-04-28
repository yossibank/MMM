@testable import Mock
@testable import Sample
import XCTest

final class SampleTests: XCTestCase {
    private var sampleClass: SampleClass!
    private var sampleClassMock: SampleClassProtocolMock!

    override func setUp() {
        super.setUp()

        sampleClass = .init()
        sampleClassMock = .init()
    }

    override func tearDown() {
        super.tearDown()

        sampleClass = nil
        sampleClassMock = nil
    }

    func test_sample() {
        // arrange
        let sample = sampleClass.sample()
        // act
        let expected = "sample"
        // assert
        XCTAssertEqual(
            sample,
            expected
        )
    }

    func test_sample_mock() {
        // arrange
        sampleClassMock.sampleHandler = {
            "mock"
        }

        let sample = sampleClassMock.sample()

        // act
        let expected = "mock"

        // assert
        XCTAssertEqual(
            sample,
            expected
        )
    }
}

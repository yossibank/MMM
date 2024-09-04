@testable import MMMFoundation
import XCTest

final class IntExtensionTests: XCTestCase {
    func test_withComma() {
        // arrange
        let expected = "1,000"

        // act
        let actual = 1000.withComma

        // assert
        XCTAssertEqual(
            actual,
            expected
        )
    }
}

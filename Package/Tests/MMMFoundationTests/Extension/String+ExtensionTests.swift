@testable import MMMFoundation
import XCTest

final class StringExtensionTests: XCTestCase {
    func test_comma() {
        // arrange
        let expected = ","

        // act
        let actual = String.comma

        // assert
        XCTAssertEqual(
            actual,
            expected
        )
    }
}

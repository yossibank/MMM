@testable import Utility
import XCTest

final class UnwrappedExtensionTests: XCTestCase {
    func test_unwrapped_string() {
        XCTContext.runActivity(named: "value") { _ in
            // arrange
            let value: String? = "test"
            let expected = "test"

            // act
            let actual = value.unwrapped

            // assert
            XCTAssertEqual(
                actual,
                expected
            )
        }

        XCTContext.runActivity(named: "nil") { _ in
            // arrange
            let value: String? = nil
            let expected = ""

            // act
            let actual = value.unwrapped

            // assert
            XCTAssertEqual(
                actual,
                expected
            )
        }
    }

    func test_unwrapped_int() {
        XCTContext.runActivity(named: "value") { _ in
            // arrange
            let value: Int? = 12345
            let expected = 12345

            // act
            let actual = value.unwrapped

            // assert
            XCTAssertEqual(
                actual,
                expected
            )
        }

        XCTContext.runActivity(named: "nil") { _ in
            // arrange
            let value: Int? = nil
            let expected = 0

            // act
            let actual = value.unwrapped

            // assert
            XCTAssertEqual(
                actual,
                expected
            )
        }
    }

    func test_unwrapped_double() {
        XCTContext.runActivity(named: "value") { _ in
            // arrange
            let value: Double? = 123.45
            let expected = 123.45

            // act
            let actual = value.unwrapped

            // assert
            XCTAssertEqual(
                actual,
                expected
            )
        }

        XCTContext.runActivity(named: "nil") { _ in
            // arrange
            let value: Double? = nil
            let expected: Double = 0

            // act
            let actual = value.unwrapped

            // assert
            XCTAssertEqual(
                actual,
                expected
            )
        }
    }

    func test_unwrapped_cgFloat() {
        XCTContext.runActivity(named: "value") { _ in
            // arrange
            let value: CGFloat? = 12345.6789
            let expected = 12345.6789

            // act
            let actual = value.unwrapped

            // assert
            XCTAssertEqual(
                actual,
                expected
            )
        }

        XCTContext.runActivity(named: "nil") { _ in
            // arrange
            let value: CGFloat? = 0
            let expected: CGFloat = 0

            // act
            let actual = value.unwrapped

            // assert
            XCTAssertEqual(
                actual,
                expected
            )
        }
    }

    func test_unwrapped_bool() {
        XCTContext.runActivity(named: "value") { _ in
            // arrange
            let value: Bool? = true
            let expected = true

            // act
            let actual = value.unwrapped

            // assert
            XCTAssertEqual(
                actual,
                expected
            )
        }

        XCTContext.runActivity(named: "nil") { _ in
            // arrange
            let value: Bool? = false
            let expected = false

            // act
            let actual = value.unwrapped

            // assert
            XCTAssertEqual(
                actual,
                expected
            )
        }
    }
}

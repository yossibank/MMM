@testable import MMMFoundation
import XCTest

final class DateExtensionTests: XCTestCase {
    func test_beforeDay() {
        // arrange
        let value = Calendar.current.date(
            from: .init(
                year: 2020,
                month: 1,
                day: 1
            )
        )!

        let expected = Calendar.current.date(
            from: .init(
                year: 2019,
                month: 12,
                day: 31
            )
        )!

        // act
        let actual = value.beforeDay

        // assert
        XCTAssertEqual(
            actual,
            expected
        )
    }

    func test_afterDay() {
        // arrange
        let value = Calendar.current.date(
            from: .init(
                year: 2020,
                month: 1,
                day: 1
            )
        )!

        let expected = Calendar.current.date(
            from: .init(
                year: 2020,
                month: 1,
                day: 2
            )
        )!

        // act
        let actual = value.afterDay

        // assert
        XCTAssertEqual(
            actual,
            expected
        )
    }
}

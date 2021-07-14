import XCTest
@testable import SwiftLocator

final class SwiftLocatorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftLocator().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

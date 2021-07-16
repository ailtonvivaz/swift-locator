import XCTest
@testable import SwiftLocator

final class SwiftLocatorTests: XCTestCase {
    
    func testRegisterSingletonWithString() {
        let get = Locator.main
        
        let testString = "Hello, World!"
        get.registerSingleton(testString)
        
        let string: String = get()
        XCTAssertEqual(string, testString)
    }

    static var allTests = [
        ("testRegisterSingletonWithString", testRegisterSingletonWithString),
    ]
}

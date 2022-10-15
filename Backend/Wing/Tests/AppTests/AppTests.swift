@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    
    func testJson() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "json", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    
}

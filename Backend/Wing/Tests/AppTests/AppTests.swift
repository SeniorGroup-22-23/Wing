@testable import App
import XCTVapor
import Models

final class AppTests: XCTestCase {
    
    //test data
    let user1 = User(id: nil, username: "janeDoe", password: "testPassword",
                     phone: "5069871234", email: "janeDoe@hotmail.com")
    
    let user2 = User(id: nil, username: "janeJones", password: "testPassword",
                     phone: "", email: "janeJones@hotmail.com")
    
    
    let prompt1 = Prompt(id: nil, promptText: "What is your favorite holiday?")
    let prompt2 = Prompt(id: nil, promptText: "How would you spend your ideal day?")

                    
    func testUsernameMatch() throws {
        /*
        let app = Application(.testing)
        
        
        defer { app.shutdown() }
        try configure(app)

        try user1.save(on: app.db).wait() //add user 1 to db
        try user2.save(on: app.db).wait() //add user 2 to db
        try app.test(.GET, "/usernames/jan", afterResponse: { response in
            XCTAssertEqual(response.status, .ok)
            XCTAssertEqual(response.body, ["janeDoe", "janeJones"])
        })
         */
    }
    
    func testGetUserbyPhone() throws {
        //TODO
    }
    
    func testGetUserbyEmail() throws {
        //TODO
    }
    
    func testPostUser() throws {
        //TODO
    }
    
    func testGetPrompts() throws {
        //TODO
    }
    
    func testPostPrompts() throws {
        //TODO
    }
    
}

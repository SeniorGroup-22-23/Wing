import FluentPostgresDriver
import Vapor
import Models

//Wrap Abort Error to Generate Custom HTTP Errors
enum Error {
    case userNotFound
}

extension Error: AbortError {
    var reason: String {
        switch self {
        case .userNotFound:
            return "No user record found."
        }
    }
    var status: HTTPStatus {
        switch self {
        case .userNotFound:
            return .notFound
        }
    }
}

//Wing Routes
func routes(_ app: Application) throws {
    
    //GET Usernames
    app.get("usernames", ":usernameMatch") {  req async throws -> [String] in
        let charMatch = req.parameters.get("usernameMatch")! //! forces decode to string, if empty no error
        return try await User.query(on: req.db)
            .filter(\.$username =~ charMatch)
            .sort(\.$username)
            .all(\.$username) //returns username field from all matches
    }
    
    //GET User by Phone 
    app.get("user", "phone", ":phone", ":password") { req async throws -> User in
        let phoneNum = req.parameters.get("phone")!
        let password = req.parameters.get("password")!
        guard let user = try await User.query(on: req.db)
            .filter(\.$phone == phoneNum)
            .filter(\.$password == password)
            .first() //Will throw error if no User is found
        else {
            throw Error.userNotFound
        }
        return user
    }
    
    //GET User by Email 
    app.get("user", "email", ":email", ":password") { req async throws -> User in
        let email = req.parameters.get("email")!
        let password = req.parameters.get("password")!
        guard let user = try await User.query(on: req.db)
            .filter(\.$email == email)
            .filter(\.$password == password)
            .first() //Will throw error if no User is found
        else {
            throw Error.userNotFound
        }
        return user
    }
    
    //POST User
    app.post("user"){ req -> EventLoopFuture<User> in
        let user = try req.content.decode(User.self)
        return user.create(on: req.db)
            .map {user}
    }
    
    //GET Prompts 
    app.get("prompts") { req async throws in
        try await Prompt.query(on: req.db).all()
    }
    
    //POST Prompt Response to user account 
    app.post("prompts", "user"){ req -> EventLoopFuture<PromptResponse> in
        let promptResponse = try req.content.decode(PromptResponse.self)
        return promptResponse.create(on: req.db)
            .map { promptResponse }
    }
    
    
    //try app.register(collection: TodoController()) XCODE generated
}


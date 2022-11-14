import FluentPostgresDriver
import Vapor
import Models

//Wrap Abort Error to Generate Custom HTTP Errors
enum Error {
    case userNotFound
    case promptNotFound
}

extension Error: AbortError {
    var reason: String {
        switch self {
        case .userNotFound:
            return "No user record found."
        case .promptNotFound:
            return "No prompt record found."
        }
    }
    var status: HTTPStatus {
        switch self {
        case .userNotFound:
            return .notFound
        case .promptNotFound:
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
    
    //PUT User (update user account)
    app.put("user"){ req -> User in
        let user = try req.content.decode(User.self)
        User.query(on: req.db)
            .set(\.$phone, to : user.phone)
            .set(\.$email, to : user.email)
            .set(\.$password, to : user.password)
            .filter(\.$id == user.id!)
            .update()
        return user
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
    
    
    //GET Prompt by Prompt ID
    app.get("prompt", ":promptId") { req async throws -> Prompt in
        let promptId = UUID(uuidString: req.parameters.get("promptId")!)!
        guard let prompt = try await Prompt.query(on: req.db)
            .filter(\.$id == promptId)
            .first()
        else {
            throw Error.promptNotFound
        }
        
        return prompt
    }
    
    
    //GET Prompts by UserID (all prompt responses by user ID)
    app.get("prompts", ":userId") { req async throws -> [PromptResponse] in
        let userId = UUID(uuidString: req.parameters.get("userId")!)!
        let prompts = try await PromptResponse.query(on: req.db)
            .filter(\.$userId == userId)
            .all()
        return prompts
    }
    
    
    //PATCH Prompt Response (update prompts for a user)
    /*
    app.put("prompts", "user", ":id"){ req async throws -> void in
        let recordId = UUID(uuidString: req.parameters.get("id")!)!
        let newText = req.content["responseText"]!
        PromptResponse.query(on: req.db)
            .set(\.$responseText, to: newText)
            .filter(\.$id == recordId)
            .update()
    }
    */
    
    
    //DELETE Prompt Response (remove prompt from user)
    app.delete("promptResponse", ":id"){ req async throws -> Response in
       guard let id = UUID(uuidString: req.parameters.get("id")!)
        else {
           return Response(status: .badRequest)
       }
        try await PromptResponse.query(on: req.db)
            .filter(\.$id == id)
            .delete()
        return Response(status: .accepted)
    }
    
    
    //try app.register(collection: TodoController()) XCODE generated
}


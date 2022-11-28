import FluentPostgresDriver
import Vapor
import Models

//Wrap Abort Error to Generate Custom HTTP Errors
enum Error {
    case userNotFound
    case promptNotFound
    case profileNotFound
    case nilId
}

extension Error: AbortError {
    var reason: String {
        switch self {
        case .userNotFound:
            return "No user record found."
        case .promptNotFound:
            return "No prompt record found."
        case .profileNotFound:
            return "No profile found."
        case .nilId:
            return "Illegal nil ID."
        }
    }
    var status: HTTPStatus {
        switch self {
        case .userNotFound:
            return .notFound
        case .promptNotFound:
            return .notFound
        case .profileNotFound:
            return .notFound
        case .nilId:
            return .notFound
        }
    }
}

//Wing Routes
func routes(_ app: Application) throws {
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
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
    app.post("user"){ req async throws -> User in
        let user = try req.content.decode(User.self)
        try await user.create(on: req.db)
        return user
    }
    
    //PUT User (update user account)
    app.put("user"){ req async throws -> User in
        let user = try req.content.decode(User.self)
        try await User.query(on: req.db)
            .set(\.$phone, to : user.phone)
            .set(\.$email, to : user.email)
            .set(\.$password, to : user.password)
            .filter(\.$id == user.id!)
            .update()
        return user
    }
    
    //GET Profile by UserId
    app.get("profile", ":userId") {req async throws -> Profile in
        guard let userId = UUID(uuidString: req.parameters.get("userId")!)
        else {
             throw Error.nilId
        }
        guard let profile = try await Profile.query(on: req.db)
            .filter(\.$userId == userId)
            .first() //Will throw error if no User is found
        else {
            throw Error.profileNotFound
        }
        return profile
    }
    
    //POST Profile
    app.post("profile"){ req async throws -> Profile  in
        let profile = try req.content.decode(Profile.self)
        try await profile.create(on: req.db)
        return profile
    }
    
    //PUT Profile
    app.put("profile"){ req async throws -> Profile in
        let profile = try req.content.decode(Profile.self)
        guard profile.id != nil else {
            throw Error.nilId
        }
        try await Profile.query(on: req.db)
            .set(\.$name, to : profile.name)
            .set(\.$occupation, to : profile.occupation)
            .set(\.$bio, to : profile.bio)
            .set(\.$preference, to : profile.preference)
            .set(\.$gender, to : profile.gender)
            .set(\.$minAge, to : profile.minAge)
            .set(\.$maxAge, to : profile.maxAge)
            .set(\.$maxDistance, to : profile.maxDistance)
            .filter(\.$id == profile.id!)
            .update()
        return profile
    }
    
    
    
    //GET Prompts
    app.get("prompts") { req async throws in
        try await Prompt.query(on: req.db).all()
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
    
    //POST Prompt Response to user account
    app.post("prompts", "user"){ req async throws -> PromptResponse in
        let promptResponse = try req.content.decode(PromptResponse.self)
        try await promptResponse.create(on: req.db)
        return promptResponse
    }
    
    //POST Prompt - Internal only!
    app.post("prompts") { req async throws in
        let prompt = try req.content.decode(Prompt.self)
        try await prompt.create(on: req.db)
        return prompt
    }
    
    //PUT Prompt Response (edit text response)
    app.put("promptResponse"){ req async throws -> PromptResponse in
        let promptRes = try req.content.decode(PromptResponse.self)
        guard promptRes.id != nil else {
            throw Error.nilId
        }
        try await PromptResponse.query(on: req.db)
            .set(\.$responseText, to : promptRes.responseText)
            .update()
        return promptRes
    }
    
    
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


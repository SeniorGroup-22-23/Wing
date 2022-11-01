import Fluent
import Vapor
import Models

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    //CREATE
    //map directly from request body content 
    app.post("users"){ req -> EventLoopFuture<User> in
        let user = try req.content.decode(Models.User.self)
        return user.create(on: req.db)
            .map { user }
    }
    
    //map directly from request body content
    app.post("prompts"){ req -> EventLoopFuture<Prompt> in
        let prompt = try req.content.decode(Prompt.self)
        return prompt.create(on: req.db)
            .map { prompt }
    }
    
    //map directly from request body content
    app.post("prompt_responses"){ req -> EventLoopFuture<PromptResponse> in
        let promptResponse = try req.content.decode(PromptResponse.self)
        return promptResponse.create(on: req.db)
            .map { promptResponse }
    }
    
    
    //GET
    app.get("users") { req async throws in
        try await User.query(on: req.db).all()
    }
    
    app.get("prompts") { req async throws in
        try await Prompt.query(on: req.db).all()
    }
    
    app.get("json") { req in
        return Person(name: "Allie M. Griffin", age: 26)
    }
    

    app.get("test_ci"){ req in
        return "Testing CI Pipeline again lol"
    }
    //try app.register(collection: TodoController())
}

struct Person: Content {
    var name: String
    var age: Int
}

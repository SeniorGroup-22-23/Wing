import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    //CREATE
    //map directly from request body content 
    app.post("users"){ req -> EventLoopFuture<User> in
        let user = try req.content.decode(User.self)
        return user.create(on: req.db)
            .map { user }
    }
    
    
    //GET
    app.get("users") { req async throws in
        try await User.query(on: req.db).all()
    }
    
    app.get("json") { req in
        return Person(name: "Allie M. Griffin", age: 26)
    }

    //try app.register(collection: TodoController())
}

struct Person: Content {
    var name: String
    var age: Int
}

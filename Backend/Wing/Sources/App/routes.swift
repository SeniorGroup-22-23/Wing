import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("newRoute") { req in
        return "New Route by Allie"
    }
    
    app.get("json") { req in
        return Person(name: "Allie M. Griffin", age: 26)
    }

    try app.register(collection: TodoController())
}

struct Person: Content {
    var name: String
    var age: Int
}

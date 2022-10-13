import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    //Unique Identifier for this user
    @ID(key: .id)
    var id: UUID?

    //profile username
    @Field(key: "username")
    var username: String
    
    //profile password
    @Field(key: "password")
    var password: String
    
    //users name
    @Field(key: "name")
    var name: String
    
    //users age
    @Field(key: "age")
    var age: Int
    

    init() { }

    init(id: UUID? = nil, username: String, password: String, name: String, age: Int) {
        self.id = id
        self.username = username
        self.password = password
        self.name = name
        self.age = age
    }
}

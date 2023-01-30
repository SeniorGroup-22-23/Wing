import Fluent
import Models

struct CreateUsers: AsyncMigration {
    
    //prepares the database for storing users
    /*
     CREATE TABLE users (
       id UUID,                                                                      username varchar NOT NULL,                                              password varchar NOT NULL,                                            name varchar NOT NULL,                                               age int NOT NULL);
     */
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required)
            .field("password", .string, .required)
            .field("phone", .string)
            .field("email", .string)
        
            .unique(on: "username", name: "no_dup_username")
            .unique(on: "phone", name: "no_dup_phone")
            .unique(on:"email", name: "no_dup_email")
    
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}

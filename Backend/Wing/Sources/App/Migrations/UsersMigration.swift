import Fluent

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
            .field("name", .string, .required)
            .field("age", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}
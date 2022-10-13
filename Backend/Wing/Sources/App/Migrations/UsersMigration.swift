import Fluent

struct CreateUsers: AsyncMigration {
    
    //prepares the database for storing users
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

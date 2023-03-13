import Fluent
import Models

struct CreateUsers: AsyncMigration {

    
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required)
            .field("password", .string, .required)
            .field("phone", .string)
            .field("email", .string)
        
            .unique(on: "username", name: "no_dup_username")

            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}

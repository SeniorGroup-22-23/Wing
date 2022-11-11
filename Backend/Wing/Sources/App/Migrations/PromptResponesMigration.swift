//
//  PromptResponsesMigration.swift
//  
//
//  Created by Courtney Perreault on 2022-10-30.
//

import Fluent
import Models

struct CreatePromptResponses: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("prompt_responses")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("prompt_id", .uuid, .required, .references("prompts", "id"))
            .field("response_text", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("prompt_responses").delete()
    }
}

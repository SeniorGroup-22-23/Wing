//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-30.
//

import Fluent

struct CreatePrompts: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("prompts")
            .id()
            .field("prompt_text", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("prompts").delete()
    }
}


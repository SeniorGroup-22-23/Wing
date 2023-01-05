//
//  profilePreviewRoutes.swift
//  
//
//  Created by Allie Griffin on 2022-12-21.
//

import FluentPostgresDriver
import Vapor
import Models


func profilePreviewRoutes(_ app: Application) throws {
    
    // create a new JSON decoder that uses unix-timestamp dates
    
    app.post("profilePreview"){ req async throws -> ProfilePreview in
        let preview = try req.content.decode(ProfilePreview.self)
        do{
            try await preview.create(on: req.db)
        } catch {
            if(error.localizedDescription.contains("profile_previews_user_id_fkey")){
                throw Error.notFoundwID("user", preview.userId)
            } else {
                throw Abort(.internalServerError, reason: "Unable to create profile: \(error)")
            }
        }
        return preview
    }
    
    app.put("profilePreview"){ req async throws -> ProfilePreview in
        let preview = try req.content.decode(ProfilePreview.self)
        guard preview.id != nil else {
            throw Error.nilId
        }
    
        try await ProfilePreview.query(on: req.db)
            .set(\.$name, to : preview.name) //update name and primary photo only (username & id are static)
            .set(\.$primaryPhoto, to : preview.primaryPhoto)
            .filter(\.$id == UUID(preview.id!.uuidString.lowercased())!)
            .update()

        return preview
    }
    
    app.get("profilePreview", "id", ":id"){ req async throws -> ProfilePreview in
        guard let id = UUID(uuidString: req.parameters.get("id")!.lowercased())
        else {
             throw Error.nilId
        }
        guard let profile = try await ProfilePreview.query(on: req.db) //get any friends where userId was requester & respondent accepted
            .filter(\.$id == id)
            .first()
        else {
            throw Error.notFoundwID("Profile Preview", id)
        }
        return profile
    }
    
    app.get("profilePreview", "username", ":username"){ req async throws -> ProfilePreview in
        let usernameMatch = req.parameters.get("username")! //! forces decode to string, if empty no error
        let profilePreview = try await ProfilePreview.query(on: req.db)
            .filter(\.$username == usernameMatch)
            .all()
        if(profilePreview.isEmpty){
            throw Error.userNotFound
        }
        return profilePreview[0]
    }
    
    app.get("profilePreview", "userId", ":userId"){ req async throws -> ProfilePreview in
        guard let userId = UUID(uuidString: req.parameters.get("userId")!.lowercased())
        else {
             throw Error.nilId
        }
        guard let profile = try await ProfilePreview.query(on: req.db) //get any friends where userId was requester & respondent accepted
            .filter(\.$userId == userId)
            .first()
        else {
            throw Error.notFoundwID("Profile Preview", userId)
        }
        return profile
    }
    
    
    
}

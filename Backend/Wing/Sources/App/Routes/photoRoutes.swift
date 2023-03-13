//
//  photoRoutes.swift
//
//
//  Created by Courtney Perreault on 2023-02-13.
//

import FluentPostgresDriver
import Vapor
import Models


func photoRoutes(_ app: Application) throws {
    
    //Post a photo to DB
    app.post("photo"){ req async throws -> Photo in
        let photo = try req.content.decode(Photo.self)
        do{
            try await photo.create(on: req.db)
        } catch {
            if(error.localizedDescription.contains("profile_previews_user_id_fkey")){
                throw Error.notFoundwID("user", photo.userId)
            } else {
                throw Abort(.internalServerError, reason: "Unable to upload photo: \(error)")
            }
        }
        return photo
    }
    
    
    app.put("photo"){ req async throws -> Photo in
        let photo = try req.content.decode(Photo.self)
        guard photo.id != nil else {
            throw Error.nilId
        }
    
        try await Photo.query(on: req.db)
            .set(\.$photo, to : photo.photo) //update photo data and/or index
            .set(\.$index, to : photo.index)
            .filter(\.$id == UUID(photo.id!.uuidString.lowercased())!)
            .update()

        return photo
    }
    
    app.get("photo", "id", ":id"){ req async throws -> Photo in
        guard let id = UUID(uuidString: req.parameters.get("id")!.lowercased())
        else {
             throw Error.nilId
        }
        guard let photo = try await Photo.query(on: req.db)
            .filter(\.$id == id)
            .first()
        else {
            throw Error.notFoundwID("Photo", id)
        }
        return photo
    }
    
    
    app.get("photo", "userId", ":userId"){ req async throws -> [Photo] in
        
        guard let userId = UUID(uuidString: req.parameters.get("userId")!.lowercased())
        else {
             throw Error.nilId
        }
        let photos = try await Photo.query(on: req.db)
            .filter(\.$userId == userId)
            .all()

        
        return photos
        
    }
    
    app.get("photo", "userId", "index", ":userId", ":index"){ req async throws -> Photo in
        guard let indexMatch = Int16(req.parameters.get("index")!)
        else{
            throw Error.nilIndex
        }
        guard let userId = UUID(uuidString: req.parameters.get("userId")!.lowercased())
        else {
             throw Error.nilId
        }//! forces decode to string, if empty no error
        guard let photo = try await Photo.query(on: req.db)
            .filter(\.$userId == userId)
            .filter(\.$index == indexMatch)
            .first()
        else{
            throw Error.photoNotFoundwIndex
        }
        return photo
    }
    
    
}

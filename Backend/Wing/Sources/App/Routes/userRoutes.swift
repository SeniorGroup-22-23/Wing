//
//  userRoutes.swift
//  User/Profile Routes 
//
//  Created by Allie Griffin on 2022-11-27.
//

import FluentPostgresDriver
import Vapor
import Models

//Wing Routes
func userRoutes(_ app: Application) throws {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    //GET Users with phone (check for unique)
    app.get("check", "phone", ":phone") { req async throws -> Bool in
        let phone = req.parameters.get("phone")!
        guard let _ = try await User.query(on: req.db)
            .filter(\.$phone == phone)
            .first()
        else{
            return true //phone is okay to use
        }
        return false //phone is duplicate (do not use)
    }
    
    //GET Users with email (check for unqiue)
    app.get("check", "email", ":email") { req async throws -> Bool in
        let email = req.parameters.get("email")!
        guard let _ = try await User.query(on: req.db)
            .filter(\.$email == email)
            .first()
        else{
            return true //email is okay to use
        }
        return false //email is duplicate (do not use)
    }
    
    //GET Usernames
    app.get("usernames", ":usernameMatch") {  req async throws -> [String] in
        let charMatch = req.parameters.get("usernameMatch")! //! forces decode to string, if empty no error
        return try await User.query(on: req.db)
            .filter(\.$username =~ charMatch)
            .sort(\.$username)
            .all(\.$username) //returns username field from all matches
    }
    
    //GET User by Phone
    app.get("user", "phone", ":phone", ":password") { req async throws -> User in
        let phoneNum = req.parameters.get("phone")!
        let password = req.parameters.get("password")!
        guard let user = try await User.query(on: req.db)
            .filter(\.$phone == phoneNum)
            .filter(\.$password == password)
            .first() //Will throw error if no User is found
        else {
            throw Error.userNotFound
        }
        return user
    }
    
    //GET User by Email
    app.get("user", "email", ":email", ":password") { req async throws -> User in
        let email = req.parameters.get("email")!
        let password = req.parameters.get("password")!
        guard let user = try await User.query(on: req.db)
            .filter(\.$email == email)
            .filter(\.$password == password)
            .first() //Will throw error if no User is found
        else {
            throw Error.userNotFound
        }
        return user
    }
    
    //POST User
    app.post("user"){ req async throws -> User in
        let user = try req.content.decode(User.self)
        do {
            try await user.create(on: req.db)
        } catch {
            if(error.localizedDescription.contains("no_dup_phone")){
                throw Error.dupVal("phone", user.phone)
            } else if (error.localizedDescription.contains("no_dup_email")){
                throw Error.dupVal("email", user.email)
            } else if (error.localizedDescription.contains("no_dup_username")){
                throw Error.dupVal("username", user.username)
            } else {
                throw Abort(.internalServerError, reason: "Unable to create user: \(error)")
            }
        }
        return user
    }
    
    //PUT User (update user account)
    app.put("user"){ req async throws -> User in
        let user = try req.content.decode(User.self)
        try await User.query(on: req.db)
            .set(\.$phone, to : user.phone)
            .set(\.$email, to : user.email)
            .set(\.$password, to : user.password)
            .filter(\.$id == UUID(user.id!.uuidString.lowercased())!)
            .update()
        return user
    }
    
    //GET Profile by UserId
    app.get("profile", ":userId") {req async throws -> Profile in
        guard let userId = UUID(uuidString: req.parameters.get("userId")!.lowercased())
        else {
             throw Error.nilId
        }
        guard let profile = try await Profile.query(on: req.db)
            .filter(\.$userId == userId)
            .first() //Will throw error if no User is found
        else {
            throw Error.profileNotFound
        }
        return profile
    }
    
    //POST Profile
    app.post("profile"){ req async throws -> Profile  in
        let profile = try req.content.decode(Profile.self)
        do {
            try await profile.create(on: req.db)
        } catch {
            if(error.localizedDescription.contains("profiles_user_id_fkey")){
                throw Error.notFoundwID("user", profile.userId)
            } else {
                throw Abort(.internalServerError, reason: "Unable to create profile: \(error)")
            }
        }
        return profile
    }
    
    //PUT Profile
    app.put("profile"){ req async throws -> Profile in
        let profile = try req.content.decode(Profile.self)
        guard profile.id != nil else {
            throw Error.nilId
        }
        try await Profile.query(on: req.db)
            .set(\.$name, to : profile.name)
            .set(\.$occupation, to : profile.occupation)
            .set(\.$bio, to : profile.bio)
            .set(\.$preference, to : profile.preference)
            .set(\.$gender, to : profile.gender)
            .set(\.$minAge, to : profile.minAge)
            .set(\.$maxAge, to : profile.maxAge)
            .set(\.$maxDistance, to : profile.maxDistance)
            .set(\.$currLongitude, to: profile.currLongitude)
            .set(\.$currLatitude, to: profile.currLatitude)
            .filter(\.$id == UUID(profile.id!.uuidString.lowercased())!)
            .update()
        return profile
    }
    
    //GET profile by profile ID
    app.get("profileId", ":profileId") { req async throws -> Profile in
        guard let profileId = UUID(uuidString: req.parameters.get("profileId")!.lowercased())
        else {
             throw Error.nilId
        }
        guard let profile = try await Profile.query(on: req.db)
            .filter(\.$id == profileId)
            .first() //Will throw error if no User is found
        else {
            throw Error.profileNotFound
        }
        return profile
    }
}

//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-24.
//

import Fluent
import Vapor

public final class Swipe: Model, Content{
    
    public static let schema = "swipes"
    
    @ID(key: .id)
    public var id: UUID?
    
    // user id referencing user that swiped on a profile
    @Field(key: "swiper")
    public var swiper: UUID
    
    //user id referencing user that was viewed and acted on by swiper
    @Field(key: "prospect")
    public var prospect: UUID
    
    // 1 = like
    // 2 = dislike
    // 3 = like from wing
    @Field(key: "type")
    public var type: String //would we rather have integer codes?
    
    //datetime when swipe occured, used to clear old records
    @Field(key: "created_at")
    public var createdAt: Date // TBD
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, swiper: UUID, prospect: UUID, type: String, createdAt: Date){
        self.id = id
        self.swiper = swiper
        self.prospect = prospect
        self.type = type
        self.createdAt = createdAt //probably will change to get date/time of initialization
    }
    
}

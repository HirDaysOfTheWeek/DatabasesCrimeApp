//
//  ReviewsObject.swift
//  Hawk
//
//  Created by Shreyas Hirday on 11/23/16.
//  Copyright © 2016 HirDaysOfTheWeek. All rights reserved.
//

import Foundation
import ObjectMapper

class VoteResponse: Mappable {
    var votes: [Vote]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        votes <- map["votes"]
    }
   
}

class Vote: Mappable {
    var rId : Int?
    var userId : String?
    var vote : Int?
    
    required init?(map: Map) {
        
    }
    
    init(rId: Int, userId : String, vote: Int) {
        self.rId = rId
        self.userId = userId
        self.vote = vote
    }
    
    func mapping(map: Map) {
        rId <- map["rId"]
        userId <- map["userId"]
        vote <- map["vote"]
    }
}

class CrimesResponse: Mappable {
    var status : String?
    var crimes : [Crime]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        crimes <- map["results"]
    }
}

class Crime : Mappable {
    var cId : String?
    var cType : String?
    var occurredAt : String?
    var cityState : String?
    var lat : Double?
    var lon : Double?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cId <- map["cId"]
        cType <- map["cType"]
        occurredAt <- map["occurredAt"]
        cityState <- map["citystate"]
        lat <- map["lat"]
        lon <- map["lon"]
    }
    
}

class ReviewsResponse: Mappable {
    var status : String?
    var message : String?
    var reviews : [Review]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        reviews <- map["results"]
    }
    
}

class Review : Mappable {
    var rId : Int?
    var rating : Double?
    var citystate : String?
    var comments : String?
    var userId : String?
    var lat : Double?
    var lon : Double?
    var date : String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        rId <- map["rId"]
        rating <- map["rating"]
        citystate <- map["citystate"]
        comments <- map["comments"]
        userId <- map["userId"]
        lat <- map["lat"]
        lon <- map["lon"]
        date <- map["postDate"]
    }

}

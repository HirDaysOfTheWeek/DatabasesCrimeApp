//
//  Networking.swift
//  Hawk
//
//  Created by Shreyas Hirday on 11/12/16.
//  Copyright © 2016 HirDaysOfTheWeek. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    
    var url: String? {
        return "http://localhost:5000"
    }

    class func register(userId : String, email : String, password : String, completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        let registerUrl = Networking().url! + "/register"
        let parameters : Parameters = [
            "userId" : userId,
            "email" : email,
            "password" : password
        ]
        Alamofire.request(registerUrl, method: .post, parameters: parameters).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                completionHandler(value as? NSDictionary, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
    }
    
    class func login(userId : String, password : String, completionHandler: @escaping (NSDictionary?, NSError?) -> () ) {
        let loginUrl = Networking().url! + "/login"
        let parameters : Parameters = [
            "userId" : userId,
            "password" : password
        ]
        Alamofire.request(loginUrl, method: .post, parameters: parameters).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                completionHandler(value as? NSDictionary, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
    }
    
    class func getCrimes(lat : Double, lon : Double, radius : Double, completionHandler: @escaping (NSDictionary?, NSError?) -> () ) {
        let getCrimesUrl = Networking().url! + "/getCrimes"
        let parameters : Parameters = [
            "lat" : lat,
            "lon" : lon,
            "radius" : radius
        ]
        Alamofire.request(getCrimesUrl, parameters: parameters).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                completionHandler(value as? NSDictionary, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
    }
    
    class func createReview(rating : Double, lat : Double, lon : Double, comments : String, userId : String, completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        let createReviewUrl = Networking().url! + "/createReview"
        let parameters : Parameters = [
            "rating" : rating,
            "lat" : lat,
            "lon" : lon,
            "comments" : comments,
            "userId" : userId
        ]
        Alamofire.request(createReviewUrl, method: .post, parameters: parameters).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                completionHandler(value as? NSDictionary, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
    }
    
    class func getReviews(lat : Double, lon : Double, radius: Double, completionHandler : @escaping (NSDictionary?, NSError?) -> ()) {
        let getReviewsUrl = Networking().url! + "/getReviews"
        let parameters : Parameters = [
            "lat" : lat,
            "lon" : lon,
            "radius" : radius
        ]
        Alamofire.request(getReviewsUrl, parameters : parameters).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                completionHandler(value as? NSDictionary, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
    }
    
    class func getReviewsByUserId(userId : String, completionHandler : @escaping (NSDictionary?, NSError?) -> ()) {
        let getReviewsByUserIdUrl = Networking().url! + "/getReviewsByUserId"
        let parameters : Parameters = [
            "userId" : userId
        ]
        Alamofire.request(getReviewsByUserIdUrl, parameters : parameters).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                completionHandler(value as? NSDictionary, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
    }
    
    class func updateCrimes(lat : Double, lon : Double, radius: Double, completionHandler : @escaping (NSDictionary?, NSError?) -> ()) {
        let updateCrimesUrl = Networking().url! + "/updateCrimes"
        let parameters : Parameters = [
            "lat" : lat,
            "lon" : lon,
            "radius" : radius
        ]
        Alamofire.request(updateCrimesUrl, parameters : parameters).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                completionHandler(value as? NSDictionary, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
    }
    
    
}

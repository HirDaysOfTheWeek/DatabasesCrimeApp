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
    
}

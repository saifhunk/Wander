//
//  APIConstants.swift
//  WanderSample
//
//  Created by Saif Chaudhary on 15/04/18.
//  Copyright © 2018 Satinder Kumar. All rights reserved.
//

import Foundation

internal struct APIConstants {
    
    static let basePath:String = "http://88.09.218.164:8000/users/"
    static let login:String = "login"
    static let userSignUp:String = "userSignUp"
    static let logout:String = "logout"
    

}



enum ResponseStatus : Error {
    
    case clientError(message : String?)
    case success
    case blocked
    case missingAuthentication
    case invalidJSON
    case noInternet
    
    var serverValue : String{
        switch self {
        case .clientError:
            return "400"
        case .success:
            return "200"
        case .missingAuthentication:
            return "401"
        default:
            return ""
        }
    }
    
    static func getRawEnum (value : String) -> ResponseStatus{
        
        switch value {
        case "200":
            return .success
        case "400":
            return .clientError(message: value)
        case "401":
            return .missingAuthentication
        default:
            return .blocked
        }
        
    }
    
}


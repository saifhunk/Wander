//
//  Network+Helpers.swift
//  WanderSample
//
//  Created by Saif Chaudhary on 15/04/18.
//  Copyright © 2018 Satinder Kumar. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftyJSON
import ObjectMapper
import Moya


public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}




class DictionaryResponse <T : Mappable> :  Mappable{
    
    var message: String?
    var data : T?
    var success: String?
    var array : [T]?
    
    required init?(map: Map){
    }
    func mapping(map: Map){
        message <- map["message"]
        data <- map["data"]
        success <- map["success"]
        array <- map["data"]
        array <- map["results"]
    }
}

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}

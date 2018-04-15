//
//  User.swift
//  WanderSample
//
//  Created by Saif Chaudhary on 15/04/18.
//  Copyright © 2018 Satinder Kumar. All rights reserved.
//


import EZSwiftExtensions
import RealmSwift
import Realm

class Notes: Object {
    
    @objc dynamic var noteId : Int64 = 0
    @objc dynamic var title :String = ""
    @objc dynamic var desc : String = ""

    
    override class func primaryKey() -> String? {
        return "noteId"
    }
    

    

    

}

//
//  RealmExtension.swift
//  WanderSample
//
//  Created by Saif Chaudhary on 15/04/18.
//  Copyright © 2018 Satinder Kumar. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

extension Object {
    
    //To save models to realm database
    func saveModel() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    //To update existing model based on primary key
    func updateModel() {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(self, update: true)
            try realm.commitWrite()
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    //To delete models saved in realm database
    func removeModel() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    //To delete all the saved models
    func removeAll<T: Object>(_ type: T.Type){
        self.retriveModel(type: type).forEach{ element in
            element.removeModel()
        }
    }
    
    //Retrive model objects from realm database
    func retriveModel<T: Object>(type: T.Type) -> [T] {
        do {
            let realm = try Realm()
            return realm.objects(T.self).toArray(ofType: T.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    //Retrive model objects from realm database by primary key
    func retriveModel<T: Object>(type: T.Type , primaryKey:Any) -> T? {
        do {
            let realm = try Realm()
            return realm.object(ofType: T.self, forPrimaryKey: primaryKey)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    //Retrive model objects from realm database using qury string eg. color = 'tan' AND name BEGINSWITH 'B'
    func retiveModel<T: Object>(type: T.Type, queryString:String) -> [T] {
        do {
            let realm = try Realm()
            return realm.objects(T.self).filter(queryString).toArray(ofType: T.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
  
  func clearWholeDB() {
    let realm = try! Realm()
    try! realm.write {
      realm.deleteAll()
    }
  }
//    func retriveMax<T: Object>(type: T.Type, property:String) -> Date {
//        
//        var date:Date?
//        do{
//            let metadata = try Realm().objects(PhassetsDetails.self)
//            if metadata.count > 0 {
//                let maxdate = metadata.max(ofProperty: "timestamp") as Date?
//                date =  /maxdate
//            }
//        }catch let error as NSError {
//            fatalError(error.localizedDescription)
//        }
//        
//        return /date
//    }

}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}



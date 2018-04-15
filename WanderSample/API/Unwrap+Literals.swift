//
//  Unwrap+Literals.swift
//  WanderSample
//
//  Created by Saif Chaudhary on 15/04/18.
//  Copyright © 2018 Satinder Kumar. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxCocoa
import RxSwift
import UIKit

extension UIImageView: OptionalType {}
extension NSObject: OptionalType {}
extension Date: OptionalType {}
extension Data: OptionalType {}
extension CGFloat: OptionalType {}
extension String: OptionalType {}
extension Int: OptionalType {}
extension Double: OptionalType {}
extension IndexPath: OptionalType {}
extension Array : OptionalType {}
extension Bool: OptionalType {}
extension UIButton: OptionalType {}
extension UIImage: OptionalType {}

protocol OptionalType {
    init()
    //static func +=( lhs: inout Self, rhs: Self)
}

prefix operator /
prefix func /<T: OptionalType>( lhs: T?) -> T {
    
    guard let validLhs = lhs else {
        return T()
    }
    return validLhs
}

prefix operator £
prefix func £(value : String?) -> String {
    return /value + " " + "$"
}

func <(d: Disposable, bag : DisposeBag) {
    d.disposed(by: bag)
}

infix operator <->

func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    let bindToUIDisposable = variable.asObservable()
        .bind(to: property)
    let bindToVariable = property
        .subscribe(onNext: { n in
            variable.value = n
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })
    
    return Disposables.create(bindToUIDisposable, bindToVariable)
}


func + <K, V> (left: [K:V]?, right: [K:V]?) -> [K:V]{
    var dict : [K:V] = left ?? [:]
    for (k, v) in right ?? [:] {
        dict[k] = v
    }
    return dict
}


infix operator =>
infix operator =|
infix operator =<

typealias OptionalJSON = [String : JSON]?

func =>(key : String, json : OptionalJSON) -> String?{
    return json?[key]?.stringValue
}

func =<(key : String, json : OptionalJSON) -> [String : JSON]?{
    return json?[key]?.dictionaryValue
}

func =|(key : String, json : OptionalJSON) -> [JSON]?{
    return json?[key]?.arrayValue
}


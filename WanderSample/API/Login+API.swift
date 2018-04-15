//
//  Login+API.swift
//  WanderSample
//
//  Created by Saif Chaudhary on 15/04/18.
//  Copyright © 2018 Satinder Kumar. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa
import Foundation
import SwiftyJSON
import ObjectMapper
import EZSwiftExtensions
import NVActivityIndicatorView


func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}


enum LoginTarget {
    
    case login(phoneNumber: String?, password: String?)
    case signUp(firstName: String?, lastName: String?, phoneNumber: String?,password:String?, countryCode: String?, about: String?)
    case logout()
    
}


fileprivate let LoginProvider = MoyaProvider <LoginTarget>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])


extension LoginTarget: TargetType {
    
    var parameters:[String: Any]? {
        switch self {
        case .login(let phoneNumber,let password):
            return ["phoneNumber": /phoneNumber,"password": /password]
        case .signUp(let firstName,let lastName,let phoneNumber,let password, let countryCode,let about):
            return ["firstName": /firstName,"lastName": /lastName, "phoneNumber": /phoneNumber, "password": /password, "countryCode": /countryCode, "about": /about]
        case .logout():
            return [:]
        }
    }
    
    var task:Task {
        switch self {
        case .login(_):
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
        case .signUp(_):
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
        case .logout():
            return .requestPlain
        }
    }
    
    var headers: [String : String]?{
        switch self {
        case .logout():
            return ["Content-type": "application/json", "authorization": "userToken"]
        default:
            return ["Content-type": "application/json"]
        }
        
    }
    
    var multipartBody: [MultipartFormData]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var token : String {
        return ""
    }
    
    public var baseURL: URL {
        switch self {
            
        default:
            return URL(string: APIConstants.basePath)!
        }
    }
    
    public var path:String {
        switch self {
        case .login(_):
            return APIConstants.login
        case .signUp(_):
            return APIConstants.userSignUp
        case .logout():
            return APIConstants.logout
        }
    }
    
    public var method: Moya.Method {
        switch self {
        default: return .post
        }
    }
    
    public var sampleData: Data { return Data() }
    
    func request(apiBarrier : Bool = false) -> Observable<Any?>{
        
        return Observable<Any?>.create { (observer) -> Disposable in
            switch(self){
            default:
                if apiBarrier{
                    self.showLoader()
                }
            }
            let disposable = Disposables.create {}
            LoginProvider.request(self, completion: { (result) in
                
                self.hideLoader()
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    let json = JSON(data)
                    
                    let status = self.handleResponse(json: json).serverValue
                    if status == ResponseStatus.success.serverValue{
                        observer.onNext(self.parse(response: json))
                        observer.on(.completed)
                    }else if status == ResponseStatus.blocked.serverValue{
                        observer.onError(ResponseStatus.blocked)
                        observer.on(.completed)
                    }else{
                        observer.onError(ResponseStatus.clientError(message: /("message" => json.dictionaryValue)))
                        observer.on(.completed)
                    }
                    
                // do something with the response data or statusCode
                case let .failure(error):
                    // this means there was a network failure - either the request
                    // wasn't sent (connectivity), or no response was received (server
                    // timed out).  If the server responds with a 4xx or 5xx error, that
                    // will be sent as a ".success"-ful response.
                    print(error.localizedDescription)
                    observer.onError(ResponseStatus.noInternet)
                    observer.on(.completed)
                    break
                }
            })
            
            return disposable
        }
    }
    
    func showLoader() {
        Loader.shared.start()
    }
    
    func hideLoader(){
        Loader.shared.stop()
    }
    
    
    func handleResponse(json : JSON) -> ResponseStatus{
        return ResponseStatus.getRawEnum(value: /("status" => json.dictionaryValue))
    }
    
    
    
    func parse(response : JSON?) -> Mappable? {
        guard let safeResponse = response else {return nil}
        switch self {
        case .login(_):
            return nil  //Mapper<DictionaryResponse<User>>().map(JSONObject: safeResponse.dictionaryObject)
        case .signUp(_):
            return nil //Mapper<DictionaryResponse<User>>().map(JSONObject: safeResponse.dictionaryObject)
        case .logout():
            return nil
        }
    }
}


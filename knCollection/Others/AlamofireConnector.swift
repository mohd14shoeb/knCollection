//
//  AlamofireConnector.swift
//  WorkshopFixir
//
//  Created by Ky Nguyen on 12/28/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireConnector {
    
    
    func get(_ api: String,
             params: [String: Any]?,
             success: @escaping (_ result: AnyObject) -> Void,
             fail: ((_ error: fxError) -> Void)?) {
        
        
        request(withApi: api, method: .get, params: params, success: success, fail: fail)
    }
    
    func request(withApi api: String,
                 method: HTTPMethod,
                 params: [String: Any]?,
                 success: @escaping (_ result: AnyObject) -> Void,
                 fail: ((_ error: fxError) -> Void)?) {
        
        let apiUrl = api.contains("http") ? api : fxServiceSetting.baseApi + api
        let url = URL(string: apiUrl)!
        let headers = fxDatastore.store.header

        Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
        .responseJSON { (response) in
            
            print("===Request: \(String(describing: response.request?.url))")
            
            if self.isPhysicalFailure(response: response) {
                print(response)
                fail?(fxError(code: .timeOut, message: response.result.error!.localizedDescription))
                print("===Error: \(response.result.error!.localizedDescription)")
                return
            }
            
            if let error = self.isLogicalFailure(response: response.result.value as AnyObject) {
                print("===Error: \(String(describing: error.message))")
                fail?(error)
                return
            }
            
            print("===Response: \(response.result.value!)")
            success(response.result.value! as AnyObject)
        }
    }
    
    func isPhysicalFailure(response: DataResponse<Any>) -> Bool {
        return response.result.error != nil
    }
    
    func isLogicalFailure(response: AnyObject) -> fxError? {

        let error = JSONParser.getBool(forKey: "error", inObject: response)
        if error == true {
            let message = JSONParser.getString(forKey: "msg", inObject: response)
            return fxError(code: .notSure, message: message)
        }
        return nil
    }
    
    func put(_ api: String,
             params: [String: Any]?,
             success: @escaping (_ result: AnyObject) -> Void,
             fail: ((_ error: fxError) -> Void)?) {
        
        request(withApi: api, method: .put, params: params, success: success, fail: fail)
    }
    
    func post(_ api: String,
              params: [String: Any]?,
              success: @escaping (_ result: AnyObject) -> Void,
              fail: ((_ error: fxError) -> Void)?) {
        
        request(withApi: api, method: .post, params: params, success: success, fail: fail)
    }
    
    
    func delete(_ api: String,
                params: [String: Any]?,
                success: @escaping (_ result: AnyObject) -> Void,
                fail: ((_ error: fxError) -> Void)?) {
        
        request(withApi: api, method: .delete, params: params, success: success, fail: fail)
    }
    
    
    
    
}

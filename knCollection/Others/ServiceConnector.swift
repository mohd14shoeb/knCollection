//
//  ServiceConnector.swift
//  WorkshopFixir
//
//  Created by Ky Nguyen on 12/28/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation
import Alamofire


struct ServiceConnector {
    
    static fileprivate var connector = AlamofireConnector()
    
    static func get(_ api: String,
                    params: [String: Any]? = nil,
                    success: @escaping (_ result: AnyObject) -> Void,
                    fail: ((_ error: fxError) -> Void)? = nil) {
        connector.get(api, params: params, success: success, fail: fail)
    }
    
    static func put(_ api: String,
                    params: [String: Any]? = nil,
                    success: @escaping (_ result: AnyObject) -> Void,
                    fail: ((_ error: fxError) -> Void)? = nil) {
        connector.put(api, params: params, success: success, fail: fail)
    }
    
    static func post(_ api: String,
                     params: [String: Any]? = nil,
                     success: @escaping (_ result: AnyObject) -> Void,
                     fail: ((_ error: fxError) -> Void)? = nil) {
        connector.post(api, params: params, success: success, fail: fail)
    }
    
    
    static func delete(_ api: String,
                       params: [String: Any]? = nil,
                       success: @escaping (_ result: AnyObject) -> Void,
                       fail: ((_ error: fxError) -> Void)? = nil) {
        connector.delete(api, params: params, success: success, fail: fail)
    }
}

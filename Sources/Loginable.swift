//
//  Loginable.swift
//  Pods
//
//  Created by Jo Albright on 1/14/16.
//
//

import Foundation


public protocol Loginable {
    
    var session: API! { get set }
    
}

extension Loginable {
    
    public var loginDetails: (auth: Endpoint, authCode: Endpoint)! { return session.loginDetails() }
    
    public func requestToken(urlString: String, var endpoint: Endpoint, api: API?, finished: (success: Bool) -> Void) {
        
        guard let code = urlString.param("code") where !code.isEmpty else { return finished(success: false) }
        
        endpoint.parameters["code"] = code
        
        api?.request(endpoint) {
            
            print($0)
            
            guard let info = $0.info as? [String:AnyObject] else { return finished(success: false) }
            guard let token = info["access_token"] as? String else { return finished(success: false) }
            
            api?.authToken = token
            finished(success: true)
            
        }
    
    }
    
}

extension String {
    
    func param(param: String) -> String? {
        
        if let urlComponents = NSURLComponents(string: self), queryItems = urlComponents.queryItems {
            return queryItems.filter({ (item) in item.name == param }).first?.value
        }
        return nil
        
    }
    
}


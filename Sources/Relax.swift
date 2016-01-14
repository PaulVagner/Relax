//
//  Relax.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//
//


import Foundation


public typealias Response = (info: AnyObject?, error: ErrorType?) -> Void

private let _s = NSURLSession.sharedSession()

public class Relax {
    
    // TODO: Build auth system based on https://developer.foursquare.com/overview/auth
    // authurl -> signin -> redirecturl -> code -> tokenurl -> token
    
    public class func request(endpoint: Endpoint, response completion: Response, api: StarterAPI?) {
        
        guard let api = api else { return completion(info: nil, error: NSURLError.BadAPI) }
        guard !api.authToken.isEmpty || !endpoint.requiresUser else { return completion(info: nil, error: NSURLError.BadUser) }
        guard endpoint.satisfied else { return completion(info: nil, error: NSURLError.BadParameters) }
        
        if api.authBasic["access_token"] == "ACCESS_TOKEN" { api.authBasic["access_token"] = api.authToken }
        
        let keys = api.authBasic.flatten("&") { "\($0)=\($1)" }
        let query = api.authToken.isEmpty ? endpoint.query.isEmpty ? "?" + keys : endpoint.query + "&" + keys : endpoint.query
        let full = api.baseURL + endpoint.path + query
        
        
        
        guard let url = NSURL(string: full) else { return completion(info: nil, error: NSURLError.BadURL) }
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = endpoint.method.rawValue
        request.HTTPBody = endpoint.method == .GET ? nil : try? endpoint.parameters.serialize()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if !api.authHeader.isEmpty && !api.authToken.isEmpty {
            
            request.setValue(api.authToken, forHTTPHeaderField: api.authHeader)
        
        }
        
        let task = _s.dataTaskWithRequest(request) { data, response, error in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                guard error == nil else { return completion(info: nil, error: error?.convert) }
                guard let data = data else { return completion(info: nil, error: NSURLError.BadData) }
                completion(info: try? data.unserialize(), error: nil)
                
            })
            
        }
        
        task.resume()
        
    }
    
}

public enum NSURLError: ErrorType {
    
    case NSError(String)
    case BadData
    case BadParameters
    case BadURL
    case BadAPI
    case BadUser
    
}

public extension NSError {
    
    var convert: ErrorType { return NSURLError.NSError(self.description) }
    
}


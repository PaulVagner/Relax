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
    
    public class func url(endpoint: Endpoint, api: API?) throws -> String {
        
        guard let api = api else { throw NSURLError.BadAPI }
        guard endpoint.satisfied else { throw NSURLError.BadParameters }
        
        let keys = api.authBasic.flatten("&") { "\($0)=\($1)" }
        let query = api.authToken.isEmpty ? endpoint.query.isEmpty ? "?" + keys : endpoint.query.containsString(keys) ? endpoint.query : endpoint.query + "&" + keys : endpoint.query

        return api.authURL + endpoint.path + query
        
    }
    
    public class func request(endpoint: Endpoint, response completion: Response, api: API?) {
        
        guard let api = api else { return completion(info: nil, error: NSURLError.BadAPI) }
        guard !api.authToken.isEmpty || !endpoint.requiresUser else { return completion(info: nil, error: NSURLError.BadUser) }
        guard endpoint.satisfied else { return completion(info: nil, error: NSURLError.BadParameters) }
        
        for (k,v) in api.authBasic { if v == "ACCESS_TOKEN" { api.authBasic[k] = api.authToken } }
        
        let keys = api.authBasic.flatten("&") { "\($0)=\($1)" }
        
        let query = endpoint.query.isEmpty ? "?" + keys : endpoint.query + "&" + keys
        
        let full = (endpoint.parameters["code"] != nil ? api.authURL : api.baseURL) + endpoint.path + query
        
        guard let url = NSURL(string: full) else { return completion(info: nil, error: NSURLError.BadURL) }
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = endpoint.method.rawValue
        
        if endpoint.method != .GET {
            
            request.HTTPBody = endpoint.parameters.flatten("&") { "\($0)=\($1)" }.dataUsingEncoding(NSUTF8StringEncoding)
            
        }
        
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

extension NSError {
    
    var convert: ErrorType { return NSURLError.NSError(self.description) }
    
}


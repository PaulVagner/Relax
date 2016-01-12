//
//  Relax.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//
//


import Foundation


public typealias Reaction = (info: AnyObject?, error: ErrorType?) -> ()

private let _s = NSURLSession.sharedSession()

public class Relax: Defaultable {
    
    static let session = Relax()
    
    public var api: API?
    
    public func touch(endpoint: Endpoint, reaction: Reaction) {
        
        guard endpoint.satisfied else { return reaction(info: nil, error: NSURLError.BadParameters) }
        guard let url = NSURL(string: endpoint.url) else { return reaction(info: nil, error: NSURLError.BadURL) }
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = endpoint.method.rawValue
        request.HTTPBody = endpoint.method == .GET ? nil : try? endpoint.parameters.serialize()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let authHeader = api?.authHeader { request.setValue(api?.token, forHTTPHeaderField: authHeader) }
        
        let task = _s.dataTaskWithRequest(request) { data, response, error in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                guard error == nil else { return reaction(info: nil, error: error?.convert) }
                guard let data = data else { return reaction(info: nil, error: NSURLError.BadData) }
                reaction(info: try? data.unserialize(), error: nil)
                
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
    
}

public extension NSError {
    
    var convert: ErrorType { return NSURLError.NSError(self.description) }
    
}


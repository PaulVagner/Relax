//
//  Endpoint.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//
//


import Foundation
import Encodable
import Inlinit


public typealias Parameters = [String:AnyObject]
public typealias Headers = [String:AnyObject]

public enum Method: String {
    
    case GET,POST,DELETE,PUT,PATCH,OPTIONS
    
}

public struct Endpoint {
    
    // Set on creation.
    
    public var path: String!
    public var method: Method!
    public var requiredParameters: [String] = []
    public var requiresUser: Bool = false
    
    // Set when creating request.
    
    public var pathpieces: [String:String] = [:] { didSet { for (k,v) in pathpieces { path = path.replace(":" + k, v) } } }
    public var parameters: Parameters = [:]
    public var query: String { return method == .GET && parameters.count > 0 ? "?" + parameters.flatten("&") { "\($0)=\($1)" } : "" }
    
    public var satisfied: Bool {
        
        parameter: for parameter in requiredParameters {
            
            for choice in parameter.componentsSeparatedByString(",") {
                
                guard parameters[choice] == nil else { continue parameter }
                
            }
            
            guard parameters[parameter] != nil else { return false }
        
        }
        
        return true
        
    }
    
    public init(path: String, method: Method = .GET) {
        
        self.path = path
        self.method = method
        
    }
    
    public init(path: String, method: Method = .GET, requiresUser: Bool) {
        
        self.path = path
        self.method = method
        self.requiresUser = requiresUser
        
    }
    
    public init(path: String, method: Method = .GET, requiredParameters: [String]) {
        
        self.path = path
        self.method = method
        self.requiredParameters = requiredParameters
        
    }
    
    public init(path: String, method: Method = .GET, requiredParameters: [String], requiresUser: Bool) {
        
        self.path = path
        self.method = method
        self.requiredParameters = requiredParameters
        self.requiresUser = requiresUser
        
    }
    
}

public extension String {
    
    public func replace(s1: String, _ s2: String) -> String {
        
        return self.stringByReplacingOccurrencesOfString(s1, withString: s2)
        
    }
    
}

public extension CollectionType {
    
    public func flatten(seperator: String = "", transform: (Self.Generator.Element) -> String) -> String {
        
        var flattenedElements: [String] = []
        for element in self { flattenedElements.append(transform(element)) }
        return flattenedElements.joinWithSeparator(seperator)
        
    }
    
}


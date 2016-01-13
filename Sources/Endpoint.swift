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
    
    public var path: String!
    public var pathpieces: [String:String] = [:] {
        
        didSet {
            
            for (k,v) in pathpieces { path = path.stringByReplacingOccurrencesOfString(":" + k, withString: v) }
            
        }
        
    }
    
    public var method: Method!
    public var parameters: Parameters = [:]
    
    public var query: String {
        
        return method == .GET && parameters.count > 0 ? "?" + parameters.flatten("&") { "\($0)=\($1)" } : ""
        
    }
    
    public var requiresUser: Bool = false
    public var requiredParameters: [String] = []
    
    public var satisfied: Bool {
        
        for parameter in requiredParameters { guard parameters[parameter] != nil else { return false } }; return true
        
    }
    
    public init(path: String, method: Method = .GET) {
        
        self.path = path
        self.method = method
        
    }
    
    public init(path: String, method: Method = .GET, parameters: Parameters) {
        
        self.path = path
        self.method = method
        self.parameters = parameters
        
    }
    
    public init(path: String, method: Method = .GET, parameters: Parameters, requiredParameters: [String]) {
        
        self.path = path
        self.method = method
        self.parameters = parameters
        self.requiredParameters = requiredParameters
        
    }
    
    
    public init(path: String, method: Method = .GET, requiredParameters: [String]) {
        
        self.path = path
        self.method = method
        self.requiredParameters = requiredParameters
        
    }
    
    public init(path: String, method: Method = .GET, parameters: Parameters, requiredParameters: [String], requiresUser: Bool) {
        
        self.path = path
        self.method = method
        self.parameters = parameters
        self.requiredParameters = requiredParameters
        self.requiresUser = requiresUser
        
    }
    
    
    public init(path: String, method: Method = .GET, requiredParameters: [String], requiresUser: Bool) {
        
        self.path = path
        self.method = method
        self.requiredParameters = requiredParameters
        self.requiresUser = requiresUser
        
    }
    
    
    public init(path: String, method: Method = .GET, parameters: Parameters, requiresUser: Bool) {
        
        self.path = path
        self.method = method
        self.parameters = parameters
        self.requiresUser = requiresUser
        
    }
    
    public init(path: String, method: Method = .GET, requiresUser: Bool) {
        
        self.path = path
        self.method = method
        self.requiresUser = requiresUser
        
    }
    
}

public extension CollectionType {
    
    public func flatten(seperator: String = "", transform: (Self.Generator.Element) -> String) -> String {
        
        var flattenedElements: [String] = []
        for element in self { flattenedElements.append(transform(element)) }
        return flattenedElements.joinWithSeparator(seperator)
        
    }
    
}


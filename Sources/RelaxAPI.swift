//
//  API.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//
//


import Foundation
import Inlinit

private let _s = API()

public class API: Defaultable, Inlinit {
    
    public class func session() -> API { return _s }
    
    public var baseURL: String = ""
    public var authURL: String = ""
    
    public var authBasic: [String:String] = [:]
    public var authHeader: String = ""
    
    public var authTokenKey: String = "Starter"
    public var authToken: String {
        
        get { return load(authTokenKey + "Token") ?? "" }
        set { save(authTokenKey + "Token",newValue) }
        
    }
    
    public enum RequestLibraries {
        
        case Relax
        case AlamoFire
    
    }
    
    public var requestLibrary: RequestLibraries = .Relax
    
    public required init() { }
    
    public func url(endpoint: Endpoint) throws -> String {
        
        return try Relax.url(endpoint, api: self)
        
    }
    
    public func request(endpoint: Endpoint, response: Response) {
        
        Relax.request(endpoint, response: response, api: self)
        
    }
    
    public func start() { }
    
    public func update(@noescape c: API -> Void) -> Self {
        
        c(self); return self
        
    }
    
    public func loginDetails() -> (auth: Endpoint, authCode: Endpoint) {
        
        return (Endpoint(path: ""), Endpoint(path: ""))
        
    }
    
}




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

public class StarterAPI: Defaultable, Inlinit {
    
    public static var session = StarterAPI()
    
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
    
    public func start(@noescape c: StarterAPI -> Void) -> Self {
        
        c(self); return self
        
    }
    
}




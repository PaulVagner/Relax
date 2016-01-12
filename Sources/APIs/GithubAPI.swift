//
//  GithubAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation


// Documentation : https://developer.github.com/v3/

public struct GithubAPI: API {
    
    public var baseURL: String = "https://api.github.com/"
    
    public var clientKey: String?
    public var clientSecret: String?
    public var authHeader: String? = "Authorization"
    
    public var token: String? {
        
        get { return load("GithubToken") }
        set { save("GithubToken",newValue) }
        
    }
    
    enum Endpoints: String {
        
        case Users, User, UserUpdate, UserName
        case SearchRepos, SearchCode, SearchIssues, SearchUsers
        
        var raw: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                
                .Users : Endpoint(path: "users", method: .GET),
                .User : Endpoint(path: "user", method: .GET, requiresUser: true),
                .UserUpdate : Endpoint(path: "user", method: .PATCH, requiresUser: true),
                .UserName : Endpoint(path: "users/:username", method: .GET),
                    
                .SearchRepos : Endpoint(path: "search/repositories", method: .GET),
                .SearchCode : Endpoint(path: "search/code", method: .GET),
                .SearchIssues : Endpoint(path: "search/issues", method: .GET),
                .SearchUsers : Endpoint(path: "search/users", method: .GET)
                
            ]
            
        }
        
    }

}
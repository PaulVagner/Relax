//
//  InstagramAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation
import Relax


// Documentation : https://www.instagram.com/developer/

public class InstagramAPI: StarterAPI {
    
    public enum Endpoints: String {

        // Auth
        
        case Auth, AuthCode
        
        // Users
        
        case Users, UsersMe, UsersMedia, UsersMyMedia, UsersMyMediaLiked, UsersSearch
        
        // Relationships
        
        // Media
        
        // Comments
        
        // Likes
        
        // Tags
        
        // Locations
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .Auth : Endpoint(path: "authorize", requiredParameters: ["client_id","response_type","redirect_uri"]),
                .AuthCode : Endpoint(path: "access_token", requiredParameters: ["client_id","client_secret","grant_type","redirect_uri","code"]),
            
                // Users
                
                .Users : Endpoint(path: "users/:user_id"),
                .UsersMe : Endpoint(path: "users/:user_id", requiresUser: true),
                .UsersMedia : Endpoint(path: "users/:user_id/media/recent"),
                .UsersMyMedia : Endpoint(path: "users/self/media/recent", requiresUser: true),
                .UsersMyMediaLiked : Endpoint(path: "users/self/media/liked", requiresUser: true),
                .UsersSearch : Endpoint(path: "users/search", requiredParameters: ["r"])
                
            ]
            
        }
        
    }

}
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

private let _ig = InstagramAPI()

public class InstagramAPI: API {
    
    public override class func session() -> InstagramAPI { return _ig }
    
    public override func start() {
        
        baseURL = "https://api.instagram.com/v1/"
        authURL = "https://api.instagram.com/oauth/"
        authHeader = "Authorization"
        authTokenKey = "Instagram"
        authBasic = [
            
            "client_id" : INSTAGRAM_CLIENT_ID,
            "client_secret" : INSTAGRAM_CLIENT_SECRET,
            "access_token":"ACCESS_TOKEN"
        
        ]
        
    }
    
    public override func loginDetails() -> (auth: Endpoint, authCode: Endpoint) {
        
        var auth = Endpoints.Auth.endpoint
        
        auth.parameters = [
            
            "client_id" : INSTAGRAM_CLIENT_ID,
            "response_type" : "code",
            "redirect_uri" : "https://code.jo2.co"
            
        ]
        
        var authCode = Endpoints.AuthCode.endpoint
        
        authCode.parameters = [
            
            "client_id" : INSTAGRAM_CLIENT_ID,
            "client_secret" : INSTAGRAM_CLIENT_SECRET,
            "redirect_uri" : "https://code.jo2.co",
            "grant_type" : "authorization_code"
            
        ]
        
        return (auth, authCode)
        
    }
    
    public enum Endpoints: String {

        // Auth
        
        case Auth
        case AuthCode
        
        // Users
        
        case Users
        case UsersMe
        case UsersMedia
        case UsersMyMedia
        case UsersMyMediaLiked
        case UsersSearch
        
        // Relationships
        
        case UsersMyFollows
        case UsersMyFollowers
        case UsersRequestedFollow
        case UsersRelationship
        case UsersSetRelationship
        
        // Media
        
        case Media
        case MediaShortcode
        case MediaSearch
        
        // Comments
        
        case MediaComments
        case MediaCommentsAdd
        case MediaCommentsDelete
        
        // Likes
        
        case MediaLikes
        case MediaLikesAdd
        case MediaLikesDelete
        
        // Tags
        
        case Tags
        case TagsMedia
        case TagsSearch
        
        // Locations
        
        case Locations
        case LocationsMedia
        case LocationsSearch
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .Auth : Endpoint(path: "authorize", requiredParameters: ["client_id","response_type","redirect_uri"]),
                .AuthCode : Endpoint(path: "access_token", method: .POST, requiredParameters: ["client_id","client_secret","grant_type","redirect_uri","code"]),
            
                // Users
                
                .Users : Endpoint(path: "users/:user_id", requiresUser: true),
                .UsersMe : Endpoint(path: "users/:user_id", requiresUser: true),
                .UsersMedia : Endpoint(path: "users/:user_id/media/recent", requiresUser: true),
                .UsersMyMedia : Endpoint(path: "users/self/media/recent", requiresUser: true),
                .UsersMyMediaLiked : Endpoint(path: "users/self/media/liked", requiresUser: true),
                .UsersSearch : Endpoint(path: "users/search", requiredParameters: ["r"], requiresUser: true),
                
                // Relationships
                
                .UsersMyFollows : Endpoint(path: "users/self/follows", requiresUser: true),
                .UsersMyFollowers : Endpoint(path: "users/self/followed-by", requiresUser: true),
                .UsersRequestedFollow : Endpoint(path: "users/self/requested-by", requiresUser: true),
                .UsersRelationship : Endpoint(path: "users/:user_id/relationship", requiresUser: true),
                .UsersSetRelationship : Endpoint(path: "users/:user_id/relationship", method: .POST, requiresUser: true),
                
                // Media
                
                .Media : Endpoint(path: "media/:media_id", requiresUser: true),
                .MediaShortcode : Endpoint(path: "media/shortcode/:shortcode", requiresUser: true),
                .MediaSearch : Endpoint(path: "media/search", requiredParameters: ["lat","lng"], requiresUser: true),
                
                // Comments
                
                .MediaComments : Endpoint(path: "media/:media_id/comments", requiresUser: true),
                .MediaCommentsAdd : Endpoint(path: "media/:media_id/comments", method: .POST, requiresUser: true),
                .MediaCommentsDelete : Endpoint(path: "media/:media_id/comments/:comment_id", method: .DELETE, requiresUser: true),
                
                // Likes
                
                .MediaLikes : Endpoint(path: "media/:media_id/likes", requiresUser: true),
                .MediaLikesAdd : Endpoint(path: "media/:media_id/likes", method: .POST, requiresUser: true),
                .MediaLikesDelete : Endpoint(path: "media/:media_id/likes", method: .DELETE, requiresUser: true),
                
                // Tags
                
                .Tags : Endpoint(path: "tags/:tag_name", requiresUser: true),
                .TagsMedia : Endpoint(path: "tags/:tag_name/media/recent", requiresUser: true),
                .TagsSearch : Endpoint(path: "tags/search", requiredParameters: ["q"], requiresUser: true),
                
                // Locations
                
                .Locations : Endpoint(path: "locations/:location_id", requiresUser: true),
                .LocationsMedia : Endpoint(path: "locations/:location_id/media/recent", requiresUser: true),
                .LocationsSearch : Endpoint(path: "locations/search", requiredParameters: ["facebook_places_id,lat,lng,foursquare_id,foursquare_v2_id"], requiresUser: true)
                
            ]
            
        }
        
    }

}
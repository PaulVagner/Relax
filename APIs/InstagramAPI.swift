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
        
        case UsersMyFollows, UsersMyFollowers, UsersRequestedFollow, UsersRelationship, UsersSetRelationship
        
        // Media
        
        case Media, MediaShortcode, MediaSearch
        
        // Comments
        
        case MediaComments, MediaCommentsAdd, MediaCommentsDelete
        
        // Likes
        
        case MediaLikes, MediaLikesAdd, MediaLikesDelete
        
        // Tags
        
        case Tags, TagsMedia, TagsSearch
        
        // Locations
        
        case Locations, LocationsMedia, LocationsSearch
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .Auth : Endpoint(path: "authorize", requiredParameters: ["client_id","response_type","redirect_uri"]),
                .AuthCode : Endpoint(path: "access_token", requiredParameters: ["client_id","client_secret","grant_type","redirect_uri","code"]),
            
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
//
//  FoursquareAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation
import Relax


// Documentation : https://developer.foursquare.com

public class FoursquareAPI: StarterAPI, API {
    
    public static var session = FoursquareAPI()
    
    public var baseURL: String = "https://api.foursquare.com/v2/"
    
    public var authBasic: [String:String] = ["v":"20160112"]
    public var authHeader: String = "Authorization"
    public var authToken: String {
        
        get { return load("FoursquareToken") ?? "" }
        set { save("FoursquareToken",newValue) }
        
    }
    
    public enum Endpoints: String {
        
        case Users, UsersRequests, UsersSearch
        // users aspects & actions
        
        case Venues, VenuesAdd, VenuesCategories, VenuesExplore, VenuesManaged, VenuesSearch, VenuesSuggestedCompletion, VenuesTimeSeries, VenuesTrending
        // venues aspects & actions
        
        case VenueGroups, VenueGroupsAdd, VenueGroupsDelete, VenueGroupsList
        // venuegroups aspects & actions
        
        // checkins general, aspects, & actions
        
        // tips general, aspects, & actions
        
        // lists general, aspects, & actions
        
        // updates general & actions
        
        case Photos, PhotosAdd
        
        case Settings, SettingsAll, SettingsSet
        
        // speacials general & actions
        
        // events general & actions
        
        // pages general, aspects, & actions
        
        // pageupdates general, aspects, & actions
        
        case MultiGET, MultiPOST
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Users
                
                .Users : Endpoint(path: "users/:user_id"),
                .UsersRequests : Endpoint(path: "users/requests", requiresUser: true),
                .UsersSearch : Endpoint(path: "users/search", requiresUser: true),
                
                // Venues
                
                .Venues : Endpoint(path: "venues/:venue_id"),
                .VenuesAdd : Endpoint(path: "venues/add", method: .POST, requiredParameters: ["name"], requiresUser: true),
                .VenuesCategories : Endpoint(path: "venues/categories"),
                .VenuesExplore : Endpoint(path: "venues/explore", requiredParameters: ["ll,near"]),
                .VenuesManaged : Endpoint(path: "venues/managed", requiresUser: true),
                .VenuesSearch : Endpoint(path: "venues/search", requiredParameters: ["ll,near"]),
                .VenuesSuggestedCompletion : Endpoint(path: "venues/suggestcompletion", requiredParameters: ["ll,near","query"]),
                .VenuesTimeSeries : Endpoint(path: "venues/timeseries", requiresUser: true),
                .VenuesTrending : Endpoint(path: "venues/trending", requiredParameters: ["ll"]),
                
                // Venue Groups
                
                .VenueGroups : Endpoint(path: "venuegroups/:group_id", requiresUser: true),
                .VenueGroupsAdd : Endpoint(path: "venuegroups/add", method: .POST, requiredParameters: ["name"], requiresUser: true),
                .VenueGroupsDelete : Endpoint(path: "venuegroups/:group_id/delete", method: .POST, requiresUser: true),
                .VenueGroupsList : Endpoint(path: "venuegroups/list", requiresUser: true),
                
                // Photos
                
                .Photos : Endpoint(path: "photos/:photo_id", requiresUser: true),
                .PhotosAdd : Endpoint(path: "photos/add", method: .POST, requiresUser: true),
                
                // Settings
                
                .Settings : Endpoint(path: "settings/:setting_id", requiresUser: true),
                .SettingsAll : Endpoint(path: "settings/all", requiresUser: true),
                .SettingsSet : Endpoint(path: "settings/:setting_id/set", method: .POST, requiredParameters: ["value"], requiresUser: true),
                
                // Multi
                
                .MultiGET : Endpoint(path: "multi", requiredParameters: ["requests"]),
                .MultiPOST : Endpoint(path: "multi", method: .POST, requiredParameters: ["requests"])
                
            ]
            
        }
        
    }
    
}
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

private let _fs = FoursquareAPI()

public class FoursquareAPI: API {
    
    public override class func session() -> FoursquareAPI { return _fs }
    
    public override func start() {
        
        baseURL = "https://api.foursquare.com/v2/"
        authURL = "https://foursquare.com/oauth2/"
        authTokenKey = "Foursquare"
        authBasic = [
            
            "client_id" : FOURSQUARE_CLIENT_ID,
            "client_secret" : FOURSQUARE_CLIENT_SECRET,
            "access_token" : "ACCESS_TOKEN",
            "v" : "20160112"
            
        ]
        
    }
    
    public override func loginDetails() -> (auth: Endpoint, authCode: Endpoint) {
        
        var auth = Endpoints.Auth.endpoint
        
        auth.parameters = [
            
            "client_id" : FOURSQUARE_CLIENT_ID,
            "response_type" : "code",
            "redirect_uri" : "https://code.jo2.co"
            
        ]
        
        var authCode = Endpoints.AuthCode.endpoint
        
        authCode.parameters = [
            
            "client_id" : FOURSQUARE_CLIENT_ID,
            "client_secret" : FOURSQUARE_CLIENT_SECRET,
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
        case UsersRequests
        case UsersSearch
        case UsersCheckins
        case UsersFriends
        case UsersLists
        case UsersMayorships
        case UsersPhotos
        case UsersTastes
        case UsersVenueHistory
        case UsersVenueLikes
        case UsersApprove
        case UsersDeny
        case UsersSetPings
        case UsersUnfriend
        case UsersUpdate
        
        // Venues
        
        /// Get venue by :venue_id
        case Venues
        /// Add new venue
        case VenuesAdd
        case VenuesCategories
        /// Explore suggested venues using "near" or "ll"
        case VenuesExplore
        case VenuesManaged
        /// Search all venues using "near" or "ll"
        case VenuesSearch
        case VenuesSuggestedCompletion
        case VenuesTimeSeries
        case VenuesTrending
        case VenuesEvents
        case VenuesHereNow
        case VenuesHours
        case VenuesLikes
        case VenuesLinks
        case VenuesListed
        case VenuesMenu
        case VenuesNextVenues
        case VenuesPhotos
        case VenuesSimilar
        case VenuesStats
        case VenuesTips
        case VenuesClaim
        case VenuesDislike
        case VenuesFlag
        case VenuesLike
        case VenuesProposeEdit
        case VenuesSetRole
        case VenuesSetSingleLocation
        
        // Venue Groups
        
        case VenueGroups
        case VenueGroupsAdd
        case VenueGroupsDelete
        case VenueGroupsList
        case VenueGroupsTimeSeries
        case VenueGroupsAddVenue
        case VenueGroupsEdit
        case VenueGroupsRemoveVenue
        case VenueGroupsUpdate
        
        // Checkins
        
        case Checkins
        case CheckinsAdd
        case CheckinsRecent
        case CheckinsResolve
        case CheckinsLikes
        case CheckinsAddComment
        case CheckinsAddPost
        case CheckinsDeleteComment
        case CheckinsLike
        
        // Tips
        
        case Tips
        case TipsAdd
        case TipsLikes
        case TipsListed
        case TipsSaves
        case TipsFlag
        case TipsLike
        case TipsUnmark
        
        // Lists
        
        case Lists
        case ListsAdd
        case ListsFollowers
        case ListsItems
        case ListsSaves
        case ListsSuggestPhoto
        case ListsSuggestTip
        case ListsSuggestVenues
        case ListsAddItem
        case ListsDeleteItem
        case ListsFollow
        case ListsMoveItem
        case ListsShare
        case ListsUnfollow
        case ListsUpdate
        case ListsUpdateItem
        
        // Updates
        
        case Updates
        case UpdatesNotifications
        case UpdatesMarkNotificationsRead
        
        // Photos
        
        case Photos
        case PhotosAdd
        
        // Settings
        
        case Settings
        case SettingsAll
        case SettingsSet
        
        // Specials
        
        case Specials
        case SpecialsAdd
        case SpecialsList
        case SpecialsSearch
        case SpecialsFlag
        
        // Events
        
        case Events
        case EventsCategories
        case EventsSearch
        case EventsAdd
        
        // Pages
        
        case PagesAdd
        case PagesManaging
        case PagesAccess
        case PagesSimilar
        case PagesTimeSeries
        case PagesVenues
        case PagesFollow
        
        // Page Updates
        
        case PageUpdates
        case PageUpdatesAdd
        case PageUpdatesList
        case PageUpdatesDelete
        case PageUpdatesLike
        
        // Multi
        
        case MultiGET
        case MultiPOST
        
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .Auth : Endpoint(path: "authenticate", requiredParameters: ["client_id","response_type","redirect_uri"]),
                .AuthCode : Endpoint(path: "access_token", requiredParameters: ["client_id","client_secret","grant_type","redirect_uri","code"]),
            
                // Users
                
                .Users : Endpoint(path: "users/:user_id", requiresUser: true),
                .UsersRequests : Endpoint(path: "users/requests", requiresUser: true),
                .UsersSearch : Endpoint(path: "users/search", requiresUser: true),
                .UsersCheckins : Endpoint(path: "users/:user_id/checkins", requiresUser: true),
                .UsersFriends : Endpoint(path: "users/:user_id/friends", requiresUser: true),
                .UsersLists : Endpoint(path: "users/:user_id/lists", requiresUser: true),
                .UsersMayorships : Endpoint(path: "users/:user_id/mayorships", requiresUser: true),
                .UsersPhotos : Endpoint(path: "users/:user_id/photos", requiresUser: true),
                .UsersTastes : Endpoint(path: "users/:user_id/tastes", requiresUser: true),
                .UsersVenueHistory : Endpoint(path: "users/:user_id/venuehistory", requiresUser: true),
                .UsersVenueLikes : Endpoint(path: "users/:user_id/venuelikes", requiresUser: true),
                .UsersApprove : Endpoint(path: "users/:user_id/approve", method: .POST, requiresUser: true),
                .UsersDeny : Endpoint(path: "users/:user_id/deny", method: .POST, requiresUser: true),
                .UsersSetPings : Endpoint(path: "users/:user_id/setpings", method: .POST, requiredParameters: ["value"], requiresUser: true),
                .UsersUnfriend : Endpoint(path: "users/:user_id/unfriend", method: .POST, requiresUser: true),
                .UsersUpdate : Endpoint(path: "users/self/update", method: .POST, requiresUser: true),
                
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
                .VenuesEvents : Endpoint(path: "venues/:venue_id/events"),
                .VenuesHereNow : Endpoint(path: "venues/:venue_id/herenow", requiresUser: true),
                .VenuesHours : Endpoint(path: "venues/:venue_id/hours"),
                .VenuesLikes : Endpoint(path: "venues/:venue_id/likes"),
                .VenuesLinks : Endpoint(path: "venues/:venue_id/links"),
                .VenuesListed : Endpoint(path: "venues/:venue_id/listed"),
                .VenuesMenu : Endpoint(path: "venues/:venue_id/menu"),
                .VenuesNextVenues : Endpoint(path: "venues/:venue_id/nextvenues"),
                .VenuesPhotos : Endpoint(path: "venues/:venue_id/photos"),
                .VenuesSimilar : Endpoint(path: "venues/:venue_id/similar", requiresUser: true),
                .VenuesStats : Endpoint(path: "venues/:venue_id/stats", requiresUser: true),
                .VenuesTips : Endpoint(path: "venues/:venue_id/tips"),
                .VenuesClaim : Endpoint(path: "venues/:venue_id/claim", method: .POST, requiresUser: true),
                .VenuesDislike : Endpoint(path: "venues/:venue_id/dislike", method: .POST, requiresUser: true),
                .VenuesFlag : Endpoint(path: "venues/:venue_id/flag", method: .POST, requiredParameters: ["problem"], requiresUser: true),
                .VenuesLike : Endpoint(path: "venues/:venue_id/like", method: .POST, requiresUser: true),
                .VenuesProposeEdit : Endpoint(path: "venues/:venue_id/proposeedit", method: .POST, requiresUser: true),
                .VenuesSetRole : Endpoint(path: "venues/:venue_id/setrole", method: .POST, requiresUser: true),
                .VenuesSetSingleLocation : Endpoint(path: "venues/:venue_id/setsinglelocation", requiresUser: true),
                
                // Venue Groups
                
                .VenueGroups : Endpoint(path: "venuegroups/:group_id", requiresUser: true),
                .VenueGroupsAdd : Endpoint(path: "venuegroups/add", method: .POST, requiredParameters: ["name"], requiresUser: true),
                .VenueGroupsDelete : Endpoint(path: "venuegroups/:group_id/delete", method: .POST, requiresUser: true),
                .VenueGroupsList : Endpoint(path: "venuegroups/list", requiresUser: true),
                .VenueGroupsTimeSeries : Endpoint(path: "venuegroups/:group_id/timeseries", requiredParameters: ["startAt"], requiresUser: true),
                .VenueGroupsAddVenue : Endpoint(path: "venuegroups/:group_id/addvenue", method: .POST, requiredParameters: ["venueId"], requiresUser: true),
                .VenueGroupsEdit : Endpoint(path: "venuegroups/:group_id/edit", method: .POST, requiresUser: true),
                .VenueGroupsRemoveVenue : Endpoint(path: "venuegroups/:group_id/removevenue", method: .POST, requiredParameters: ["venueId"], requiresUser: true),
                .VenueGroupsUpdate : Endpoint(path: "venuegroups/:group_id/update", method: .POST, requiresUser: true),
                
                // Checkins
                
                .Checkins : Endpoint(path: "checkins/:checkin_id", requiresUser: true),
                .CheckinsAdd : Endpoint(path: "checkins/add", method: .POST, requiredParameters: ["venueId"], requiresUser: true),
                .CheckinsRecent : Endpoint(path: "checkins/recent", requiresUser: true),
                .CheckinsResolve : Endpoint(path: "checkins/resolve", requiredParameters: ["shortId"], requiresUser: true),
                .CheckinsLikes : Endpoint(path: "checkins/:checkin_id/likes"),
                .CheckinsAddComment : Endpoint(path: "checkins/:checkin_id/addcomment", method: .POST, requiresUser: true),
                .CheckinsAddPost : Endpoint(path: "checkins/:checkin_id/addpost", method: .POST, requiresUser: true),
                .CheckinsDeleteComment : Endpoint(path: "checkins/:checkin_id/deletecomment", method: .POST, requiresUser: true),
                .CheckinsLike : Endpoint(path: "checkins/:checkin_id/like", method: .POST, requiresUser: true),

                // Tips
                
                .Tips : Endpoint(path: "tips/:tip_id"),
                .TipsAdd : Endpoint(path: "tips/add", method: .POST, requiredParameters: ["venueId","text"], requiresUser: true),
                .TipsLikes : Endpoint(path: "tips/:tip_id/likes"),
                .TipsListed : Endpoint(path: "tips/:tip_id/listed"),
                .TipsSaves : Endpoint(path: "tips/:tip_id/saves"),
                .TipsFlag : Endpoint(path: "tips/:tip_id/flag", method: .POST, requiredParameters: ["problem"], requiresUser: true),
                .TipsLike : Endpoint(path: "tips/:tip_id/like", method: .POST, requiresUser: true),
                .TipsUnmark : Endpoint(path: "tips/:tip_id/unmark", method: .POST, requiresUser: true),
                
                // Lists
                
                .Lists : Endpoint(path: "lists/:list_id"),
                .ListsAdd : Endpoint(path: "lists/add", method: .POST, requiredParameters: ["name"], requiresUser: true),
                .ListsFollowers : Endpoint(path: "lists/:list_id/followers"),
                .ListsItems : Endpoint(path: "lists/:list_id/:item_id", requiresUser: true),
                .ListsSaves : Endpoint(path: "lists/:list_id/saves"),
                .ListsSuggestPhoto : Endpoint(path: "lists/:list_id/suggestphoto", requiredParameters: ["itemId"], requiresUser: true),
                .ListsSuggestTip : Endpoint(path: "lists/:list_id/suggesttip", requiredParameters: ["itemId"], requiresUser: true),
                .ListsSuggestVenues : Endpoint(path: "lists/:list_id/suggestvenues", requiresUser: true),
                .ListsAddItem : Endpoint(path: "lists/:list_id/additem", method: .POST, requiredParameters: ["venueId,tipId,itemId"], requiresUser: true),
                .ListsDeleteItem : Endpoint(path: "lists/:list_id/deleteitem", method: .POST, requiredParameters: ["venueId,tipId,itemId"], requiresUser: true),
                .ListsFollow : Endpoint(path: "lists/:list_id/follow", method: .POST, requiresUser: true),
                .ListsMoveItem : Endpoint(path: "lists/:list_id/moveitem", method: .POST, requiredParameters: ["itemId","beforeId,afterId"], requiresUser: true),
                .ListsShare : Endpoint(path: "lists/:list_id/share", method: .POST, requiresUser: true),
                .ListsUnfollow : Endpoint(path: "lists/:list_id/unfollow", method: .POST, requiresUser: true),
                .ListsUpdate : Endpoint(path: "lists/:list_id/update", method: .POST, requiresUser: true),
                .ListsUpdateItem : Endpoint(path: "lists/:list_id/updateitem", method: .POST, requiredParameters: ["itemId"], requiresUser: true),
                
                // Updates
                
                .Updates : Endpoint(path: "updates/:update_id", requiresUser: true),
                .UpdatesNotifications : Endpoint(path: "updates/notifications", requiresUser: true),
                .UpdatesMarkNotificationsRead : Endpoint(path: "updates/marknotificationsread", method: .POST, requiredParameters: ["highWatermark"], requiresUser: true),
                
                // Photos
                
                .Photos : Endpoint(path: "photos/:photo_id", requiresUser: true),
                .PhotosAdd : Endpoint(path: "photos/add", method: .POST, requiresUser: true),
                
                // Settings
                
                .Settings : Endpoint(path: "settings/:setting_id", requiresUser: true),
                .SettingsAll : Endpoint(path: "settings/all", requiresUser: true),
                .SettingsSet : Endpoint(path: "settings/:setting_id/set", method: .POST, requiredParameters: ["value"], requiresUser: true),
                
                // Specials
                
                .Specials : Endpoint(path: "specials/:special_id", requiredParameters: ["venueId"]),
                .SpecialsAdd : Endpoint(path: "specials/add", method: .POST, requiredParameters: ["text","type"], requiresUser: true),
                .SpecialsList : Endpoint(path: "specials/list", requiresUser: true),
                .SpecialsSearch : Endpoint(path: "specials/search", requiredParameters: ["ll"]),
                .SpecialsFlag : Endpoint(path: "specials/:special_id/flag", method: .POST, requiredParameters: ["venueId","problem"], requiresUser: true),
                
                // Events
                
                .Events : Endpoint(path: "events/:event_id", requiresUser: true),
                .EventsCategories : Endpoint(path: "events/categories"),
                .EventsSearch : Endpoint(path: "events/search", requiredParameters: ["domain","eventId,participantId"]),
                .EventsAdd : Endpoint(path: "events/add", method: .POST, requiresUser: true),
                
                // Pages
                
                .PagesAdd : Endpoint(path: "pages/add", method: .POST, requiredParameters: ["name"], requiresUser: true),
                .PagesManaging : Endpoint(path: "pages/managing", requiresUser: true),
                .PagesAccess : Endpoint(path: "pages/:user_id/access", requiresUser: true),
                .PagesSimilar : Endpoint(path: "pages/:user_id/similar", requiresUser: true),
                .PagesTimeSeries : Endpoint(path: "pages/:page_id/timeseries", requiredParameters: ["startAt"], requiresUser: true),
                .PagesVenues : Endpoint(path: "pages/:page_id/venues"),
                .PagesFollow : Endpoint(path: "pages/:user_id/follow", method: .POST, requiresUser: true),
                
                // Page Updates
                
                .PageUpdates : Endpoint(path: "pageupdates/:update_id", requiresUser: true),
                .PageUpdatesAdd : Endpoint(path: "pageupdates/add", method: .POST, requiredParameters: ["pageId"], requiresUser: true),
                .PageUpdatesList : Endpoint(path: "pageupdates/list", requiresUser: true),
                .PageUpdatesDelete : Endpoint(path: "pageupdates/:update_id/delete", method: .POST, requiresUser: true),
                .PageUpdatesLike : Endpoint(path: "pageupdates/:update_id/like", method: .POST, requiresUser: true),
                
                // Multi
                
                .MultiGET : Endpoint(path: "multi", requiredParameters: ["requests"]),
                .MultiPOST : Endpoint(path: "multi", method: .POST, requiredParameters: ["requests"])
                
            ]
            
        }
        
    }
    
}
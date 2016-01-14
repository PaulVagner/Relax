//
//  GithubAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation
import Relax


// Documentation : https://developer.github.com/v3/

public class GithubAPI: StarterAPI, API {
    
    public static var session = GithubAPI()
    
    public var baseURL: String = "https://api.github.com/"
    public var authURL: String = "https://github.com/login/oauth/"
    
    public var authBasic: [String:String] = [:]
    public var authHeader: String = "Authorization"
    public var authToken: String {
        
        get { return load("GithubToken") ?? "" }
        set { save("GithubToken",newValue) }
        
    }
    
    public enum Endpoints: String {
        
        // Auth
        
        case Auth, AuthCode
        
        // Events
        
        case Events, EventsRepo, EventsRepoIssues, EventsRepoNetworks, EventsOrg, EventsUserReceived, EventsUserReceivedPublic, EventsUserPerformed, EventsUserPerformedPublic, EventsUserOrg
        
        // Notifications
        
        case Notifications, NotificationsMarkRead, NotificationsRepo, NotificationsRepoMarkRead, NotificationsThread, NotificationsThreadMarkRead, NotificationsThreadSubscription, NotificationsThreadSetSubscription, NotificationsThreadDeleteSubscription
        
        // Stars
        
        case StarsRepoStarGazers, StarsUserStarred, StarsMeStarred, StarsRepoCheck, StarsRepoStar, StarsRepoUnstar
        
        // Watch
        
        case WatchRepoWatchers, WatchUserWatching, WatchMeWatching, WatchRepoSubscription, WatchRepoSetSubscription, WatchRepoDeleteSubscription, WatchRepoCheck, WatchRepoWatch, WatchRepoUnwatch
        
        // Gists
        
        case Gists, GistsUser, GistsMe, GistsMeStarred, Gist, GistRevision, GistCreate, GistEdit, GistDelete, GistCommits, GistCheck, GistStar, GistUnstar, GistFork, GistForks
        
        // Git Data
        
        // Issues
        
        // Misc
        
        // Org
        
        // Pull Requests
        
        // Repo
        
        // Search
        
        case SearchRepos, SearchCode, SearchIssues, SearchUsers
        
        // User
        
        case Users, UsersNamed, UsersMe, UsersMeUpdate, UsersMeEmails, UsersMeEmailsAdd, UsersMeEmailsDelete, UsersFollowers, UsersMeFollowers, UsersFollowing, UsersMeFollowing, UsersFollowingUserCheck, UsersMeFollowingUserCheck, UsersMeFollowUser, UsersMeUnfollowUser
        
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .Auth : Endpoint(path: "authorize", requiredParameters: ["client_id","redirect_uri","state"]),
                .AuthCode : Endpoint(path: "access_token", requiredParameters: ["client_id","client_secret","code","redirect_uri","state"]),
                
                // Events
                
                .Events : Endpoint(path: "events"),
                .EventsRepo : Endpoint(path: "repos/:owner/:repo/events"),
                .EventsRepoIssues : Endpoint(path: "repos/:owner/:repo/issues/events"),
                .EventsRepoNetworks : Endpoint(path: "networks/:owner/:repo/events"),
                .EventsOrg : Endpoint(path: "orgs/:org/events"),
                .EventsUserReceived : Endpoint(path: "users/:username/received_events", requiresUser: true),
                .EventsUserReceivedPublic : Endpoint(path: "users/:username/received_events/public"),
                .EventsUserPerformed : Endpoint(path: "users/:username/events", requiresUser: true),
                .EventsUserPerformedPublic : Endpoint(path: "users/:username/events/public"),
                .EventsUserOrg : Endpoint(path: "users/:username/events/orgs/:org", requiresUser: true),
                
                // Notifications
                
                .Notifications : Endpoint(path: "notifications", requiresUser: true),
                .NotificationsMarkRead : Endpoint(path: "notifications", method: .PUT, requiresUser: true),
                .NotificationsRepo : Endpoint(path: "repos/:owner/:repo/notifications", requiresUser: true),
                .NotificationsRepoMarkRead : Endpoint(path: "repos/:owner/:repo/notifications", method: .PUT, requiresUser: true),
                .NotificationsThread : Endpoint(path: "notifications/threads/:id", requiresUser: true),
                .NotificationsThreadMarkRead : Endpoint(path: "notifications/threads/:id", method: .PATCH, requiresUser: true),
                .NotificationsThreadSubscription : Endpoint(path: "notifications/threads/:id/subscription", requiresUser: true),
                .NotificationsThreadSetSubscription : Endpoint(path: "notifications/threads/:id/subscription", method: .PUT, requiresUser: true),
                .NotificationsThreadDeleteSubscription : Endpoint(path: "notifications/threads/:id/subscription", method: .DELETE, requiresUser: true),
                
                // Stars
                
                .StarsRepoStarGazers : Endpoint(path: "repos/:owner/:repo/stargazers"),
                .StarsUserStarred : Endpoint(path: "users/:username/starred"),
                .StarsMeStarred : Endpoint(path: "user/starred", requiresUser: true),
                .StarsRepoCheck : Endpoint(path: "user/starred/:owner/:repo", requiresUser: true),
                .StarsRepoStar : Endpoint(path: "user/starred/:owner/:repo", method: .PUT, requiresUser: true),
                .StarsRepoUnstar : Endpoint(path: "user/starred/:owner/:repo", method: .DELETE, requiresUser: true),
                
                // Watch
                
                .WatchRepoWatchers : Endpoint(path: "repos/:owner/:repo/subscribers"),
                .WatchUserWatching : Endpoint(path: "users/:username/subscriptions"),
                .WatchMeWatching : Endpoint(path: "user/subscriptions", requiresUser: true),
                .WatchRepoSubscription : Endpoint(path: "repos/:owner/:repo/subscription", requiresUser: true),
                .WatchRepoSetSubscription : Endpoint(path: "repos/:owner/:repo/subscription", method: .PUT, requiresUser: true),
                .WatchRepoDeleteSubscription : Endpoint(path: "repos/:owner/:repo/subscription", method: .DELETE, requiresUser: true),
                .WatchRepoCheck : Endpoint(path: "user/subscriptions/:owner/:repo", requiresUser: true),
                .WatchRepoWatch : Endpoint(path: "user/subscriptions/:owner/:repo", method: .PUT, requiresUser: true),
                .WatchRepoUnwatch : Endpoint(path: "user/subscriptions/:owner/:repo", method: .DELETE, requiresUser: true),
            
                // Gists
                
                .Gists : Endpoint(path: "gists/public"),
                .GistsUser : Endpoint(path: "users/:username/gists"),
                .GistsMe : Endpoint(path: "gists", requiresUser: true),
                .GistsMeStarred : Endpoint(path: "gists/starred", requiresUser: true),
                .Gist : Endpoint(path: "gists/:id"),
                .GistRevision : Endpoint(path: "gists/:id/:sha"),
                .GistCreate : Endpoint(path: "gists", method: .POST, requiresUser: true),
                .GistEdit : Endpoint(path: "gists/:id", method: .PATCH, requiresUser: true),
                .GistDelete : Endpoint(path: "gists/:id", method: .DELETE, requiresUser: true),
                .GistCommits : Endpoint(path: "gists/:id/commits"),
                .GistCheck : Endpoint(path: "gists/:id/star", requiresUser: true),
                .GistStar : Endpoint(path: "gists/:id/star", method: .PUT, requiresUser: true),
                .GistUnstar : Endpoint(path: "gists/:id/star", method: .DELETE, requiresUser: true),
                .GistFork : Endpoint(path: "gists/:id/forks", method: .POST, requiresUser: true),
                .GistForks : Endpoint(path: "gists/:id/forks"),
                
                // Search
                
                .SearchRepos : Endpoint(path: "search/repositories"),
                .SearchCode : Endpoint(path: "search/code"),
                .SearchIssues : Endpoint(path: "search/issues"),
                .SearchUsers : Endpoint(path: "search/users"),
                
                // User
                
                .Users : Endpoint(path: "users"),
                .UsersNamed : Endpoint(path: "users/:username"),
                .UsersMe : Endpoint(path: "user", requiresUser: true),
                .UsersMeUpdate : Endpoint(path: "user", method: .PATCH, requiresUser: true),
                .UsersMeEmails : Endpoint(path: "user/emails", requiresUser: true),
                .UsersMeEmailsAdd : Endpoint(path: "user/emails", method: .POST, requiresUser: true),
                .UsersMeEmailsDelete : Endpoint(path: "user/emails", method: .DELETE, requiresUser: true),
                .UsersFollowers : Endpoint(path: "users/:username/followers"),
                .UsersMeFollowers : Endpoint(path: "user/followers", requiresUser: true),
                .UsersFollowing : Endpoint(path: "users/:username/following"),
                .UsersMeFollowing : Endpoint(path: "user/following", requiresUser: true),
                .UsersFollowingUserCheck : Endpoint(path: "users/:username/following/:target_user"),
                .UsersMeFollowingUserCheck : Endpoint(path: "user/following/:username", requiresUser: true),
                .UsersMeFollowUser : Endpoint(path: "user/following/:username", method: .PUT, requiresUser: true),
                .UsersMeUnfollowUser : Endpoint(path: "user/following/:username", method: .DELETE, requiresUser: true)
                
            ]
            
        }
        
    }

}
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

private let _gh = GitHubAPI()

public class GitHubAPI: API {
    
    public override class func session() -> GitHubAPI { return _gh }
    
    public override func start() {
        
        baseURL = "https://api.github.com/"
        authURL = "https://github.com/login/oauth/"
        authTokenKey = "Github"
        authBasic = [
            
            "client_id" : GITHUB_CLIENT_ID,
            "client_secret" : GITHUB_CLIENT_SECRET,
            "access_token" : "ACCESS_TOKEN"
            
        ]
        
    }
    
    public override func loginDetails() -> (auth: Endpoint, authCode: Endpoint) {
        
        var auth = Endpoints.Auth.endpoint
        
        auth.parameters = [
            
            "client_id" : GITHUB_CLIENT_ID,
            "response_type" : "code",
            "redirect_uri" : "https://code.jo2.co",
            "scope" : "user,public_repo",
            "state" : "thisisawesome"
            
        ]
        
        var authCode = Endpoints.AuthCode.endpoint
        
        authCode.parameters = [
            
            "client_id" : GITHUB_CLIENT_ID,
            "client_secret" : GITHUB_CLIENT_SECRET,
            "redirect_uri" : "https://code.jo2.co",
            "state" : "thisisawesome"
            
        ]
        
        return (auth, authCode)
        
        
    }
    
    public enum Endpoints: String {
        
        // Auth
        
        case Auth
        case AuthCode
        
        // Events
        
        case Events
        case EventsRepo
        case EventsRepoIssues
        case EventsRepoNetworks
        case EventsOrg
        case EventsUserReceived
        case EventsUserReceivedPublic
        case EventsUserPerformed
        case EventsUserPerformedPublic
        case EventsUserOrg
        
        // Notifications
        
        case Notifications
        case NotificationsMarkRead
        case NotificationsRepo
        case NotificationsRepoMarkRead
        case NotificationsThread
        case NotificationsThreadMarkRead
        case NotificationsThreadSubscription
        case NotificationsThreadSetSubscription
        case NotificationsThreadDeleteSubscription
        
        // Stars
        
        case StarsRepoStarGazers
        case StarsUserStarred
        case StarsMeStarred
        case StarsRepoCheck
        case StarsRepoStar
        case StarsRepoUnstar
        
        // Watch
        
        case WatchRepoWatchers
        case WatchUserWatching
        case WatchMeWatching
        case WatchRepoSubscription
        case WatchRepoSetSubscription
        case WatchRepoDeleteSubscription
        case WatchRepoCheck
        case WatchRepoWatch
        case WatchRepoUnwatch
        
        // Gists
        
        case Gists
        case GistsUser
        case GistsMe
        case GistsMeStarred
        case Gist
        case GistRevision
        case GistCreate
        case GistEdit
        case GistDelete
        case GistCommits
        case GistCheck
        case GistStar
        case GistUnstar
        case GistFork
        case GistForks
        
        // Git Data
        
        // Issues
        
        // Misc
        
        // Org
        
        // Pull Requests
        
        // Repo
        
        // Search
        
        case SearchRepos
        case SearchCode
        case SearchIssues
        case SearchUsers
        
        // User
        
        case Users
        case UsersNamed
        case UsersMe
        case UsersMeUpdate
        case UsersMeEmails
        case UsersMeEmailsAdd
        case UsersMeEmailsDelete
        case UsersFollowers
        case UsersMeFollowers
        case UsersFollowing
        case UsersMeFollowing
        case UsersFollowingUserCheck
        case UsersMeFollowingUserCheck
        case UsersMeFollowUser
        case UsersMeUnfollowUser
        
        
        
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
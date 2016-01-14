# Relax
RESTful API endpoint manager

<!--[![CI Status](http://img.shields.io/travis/Jo Albright/Relax.svg?style=flat)](https://travis-ci.org/Jo Albright/Relax)-->
[![Version](https://img.shields.io/cocoapods/v/Relax.svg?style=flat)](http://cocoapods.org/pods/Relax)
[![License](https://img.shields.io/cocoapods/l/Relax.svg?style=flat)](http://cocoapods.org/pods/Relax)
[![Platform](https://img.shields.io/cocoapods/p/Relax.svg?style=flat)](http://cocoapods.org/pods/Relax)

## Needs

> This library will need a lot of management to keep APIs updated. My plan is to start laying them out and try to find others who use specific APIs and have them keep those up to date.

## Roadmap

#### APIs

- [x] ~~Done~~
- [ ] ***Started***
- [ ] API : [Docs]() *documentation link*
- [ ] API : [File]() *repo file*
- [ ] API : [Lead Name]() *lead contributer* 

**Please submit an issue if you would like a lead position for any (listed/unlisted) API**

--- 

- [ ] Flickr : [Docs](https://www.flickr.com/services/api/)
- [x] ~~Foursquare~~ : [Docs](https://developer.foursquare.com) : [Jo Albright](https://github.com/joalbright)
- [ ] ***Github*** : [Docs](https://developer.github.com/v3/)
- [ ] Instagram : [Docs](https://www.instagram.com/developer/)
- [x] ~~Itunes~~ : [Docs](https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html) : [Jo Albright](https://github.com/joalbright)
- [ ] LinkedIn : [Docs](https://developer.linkedin.com/docs)
- [ ] Marvel : [Docs](http://developer.marvel.com)
- [ ] Meetup : [Docs](http://www.meetup.com/meetup_api/)
- [ ] Pinterest : [Docs](https://developers.pinterest.com)
- [ ] Slack : [Docs](https://api.slack.com)
- [ ] Twitter : [Docs](https://dev.twitter.com/overview/documentation)
- [ ] Uber : [Docs](https://developer.uber.com)
- [ ] Youtube : [Docs](https://developers.google.com/youtube/)

**API Groups**

- [Google Products](https://developers.google.com/products/)
	- [ ] Analytics : [Docs](https://developers.google.com/analytics/)
	- [ ] Maps : [Docs](https://developers.google.com/maps/)
- [Facebook Products](https://developers.facebook.com/docs/)
	- [ ] Graph API : [Docs](https://developers.facebook.com/docs/graph-api)

**Please submit an issue for any APIs you would like to see added.**

#### Features

- [ ] Response Object Structure (still dreaming this up)
- [ ] Authentication System
- [ ] AlamoFire Support (other?)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Create API

```swift
// Documentation : https://developer.github.com/v3/

public class GithubAPI: StarterAPI {
    
    public enum Endpoints: String {
        
        // Auth
        
        case Auth, AuthCode
        
        // Gists
        
        case Gists, GistsUser, GistsMe, GistsMeStarred, Gist, GistRevision, GistCreate, GistEdit, GistDelete, GistCommits, GistCheck, GistStar, GistUnstar, GistFork, GistForks    
            
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
```

### Use API

**start session**

```swift
GithubAPI.session.start {
            
    $0.authBasic["client_id"] = GITHUB_CLIENT_KEY
    $0.authBasic["client_secret"] = GITHUB_CLIENT_SECRET
    
    $0.baseURL = "https://api.github.com/"
    $0.authURL = "https://github.com/login/oauth/"
    $0.authHeader = "Authorization"
    $0.authTokenKey = "Github"
    
}
```

> You will need to [register an application](https://github.com/settings/applications/new). Then create a Keys.swift file (make sure to ignore the file if your repo is public).

**run a request**

```swift
let githubAPI = GithubAPI.session
        
// setup endpoint
    
var profile = GithubAPI.Endpoints.UsersNamed.endpoint
    
profile.pathpieces = ["username" : "joalbright"]
    
// run request
    
githubAPI.request(profile) {
   
   // object returned = $0.info 
   // error returned = $0.error 
	    
}

```

## Requirements

This pod uses [Encodable](https://github.com/joalbright/Encodable).

## Installation

Relax is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Relax"
```

Relax is also available through [Swift Package Manager](https://swift.org/package-manager/). Please take a look at the link to learn more about how to use SwiftPM.

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PACKAGE_NAME",
    dependencies: [
        .Package(url: "https://github.com/joalbright/Relax.git", majorVersion: 0)
    ]
)
```

## Author

[Jo Albright](https://github.com/joalbright)

## License

Relax is available under the MIT license. See the LICENSE file for more info.

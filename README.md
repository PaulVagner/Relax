# Relax

<!--[![CI Status](http://img.shields.io/travis/Jo Albright/Relax.svg?style=flat)](https://travis-ci.org/Jo Albright/Relax)-->
[![Version](https://img.shields.io/cocoapods/v/Relax.svg?style=flat)](http://cocoapods.org/pods/Relax)
[![License](https://img.shields.io/cocoapods/l/Relax.svg?style=flat)](http://cocoapods.org/pods/Relax)
[![Platform](https://img.shields.io/cocoapods/p/Relax.svg?style=flat)](http://cocoapods.org/pods/Relax)

## Needs

> This library will need a lot of management to keep APIs updated. My plan is to start laying them out and try to find others who use specific APIs and have them keep those up to date.

## Roadmap

#### APIs

- [ ] [Flickr](https://www.flickr.com/services/api/)
- [ ] [Foursquare](https://developer.foursquare.com)
- [ ] [Github](https://developer.github.com/v3/)
- [ ] [Instagram](https://www.instagram.com/developer/)
- [x] [Itunes](https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html)
- [ ] [LinkedIn](https://developer.linkedin.com/docs)
- [ ] [Marvel](http://developer.marvel.com)
- [ ] [Meetup](http://www.meetup.com/meetup_api/)
- [ ] [Pinterest](https://developers.pinterest.com)
- [ ] [Slack](https://api.slack.com)
- [ ] [Twitter](https://dev.twitter.com/overview/documentation)
- [ ] [Uber](https://developer.uber.com)
- [ ] [Youtube](https://developers.google.com/youtube/)

---

- [Google Products](https://developers.google.com/products/)
	- [ ] [Analytics](https://developers.google.com/analytics/)
	- [ ] [Maps](https://developers.google.com/maps/)
- [Facebook Products](https://developers.facebook.com/docs/)
	- [ ] [Graph API](https://developers.facebook.com/docs/graph-api)

#### Features

- [ ] Response Object Structure (still dreaming this up)
- [ ] AlamoFire Support

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Create API

```swift
// Documentation : https://developer.github.com/v3/

class GithubAPI: StarterAPI, API {
    
    static var session = GithubAPI()
    
    var baseURL: String = "https://api.github.com/"
    
    var authBasic: [String:String] = [:]
    var authHeader: String = "Authorization"
    var authToken: String {
        
        get { return load("GithubToken") ?? "" }
        set { save("GithubToken",newValue) }
        
    }
    
    enum Endpoints: String {
                
        case Users, User, UserUpdate, UserName
        case SearchRepos, SearchCode, SearchIssues, SearchUsers
        
        var endpoint: Endpoint { return _endpoints[self]! }
        
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
    
    /*
    // uncomment to overwrite built in NSURLSession request (ex: to use AlamoFire)

    public func request(endpoint: Endpoint, response: Response) {
        
        // your custom request... then call response when it finishes
        
    }
    */

}
```

### Use API

**start session**

```swift
GithubAPI.session.start {
            
    $0.authBasic["client_id"] = GITHUB_CLIENT_KEY
    $0.authBasic["client_secret"] = GITHUB_CLIENT_SECRET
            
}
```

> You will need to [register an application](https://github.com/settings/applications/new). Then create a Keys.swift file (make sure to ignore the file if your repo is public).

**run a request**

```swift
let githubAPI = GithubAPI.session
        
// setup endpoint
    
var profile = GithubAPI.Endpoints.UserName.endpoint
    
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

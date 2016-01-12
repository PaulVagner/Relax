# Relax

<!--[![CI Status](http://img.shields.io/travis/Jo Albright/Relax.svg?style=flat)](https://travis-ci.org/Jo Albright/Relax)-->
[![Version](https://img.shields.io/cocoapods/v/Relax.svg?style=flat)](http://cocoapods.org/pods/Relax)
[![License](https://img.shields.io/cocoapods/l/Relax.svg?style=flat)](http://cocoapods.org/pods/Relax)
[![Platform](https://img.shields.io/cocoapods/p/Relax.svg?style=flat)](http://cocoapods.org/pods/Relax)

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

## Author

Jo Albright, me@jo2.co

## License

Relax is available under the MIT license. See the LICENSE file for more info.

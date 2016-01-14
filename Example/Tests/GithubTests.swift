//
//  GithubTests.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Relax

class GithubTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        GithubAPI.session.start {
            
            $0.authBasic["client_id"] = GITHUB_CLIENT_ID
            $0.authBasic["client_secret"] = GITHUB_CLIENT_SECRET
            
            $0.baseURL = "https://api.github.com/"
            $0.authURL = "https://github.com/login/oauth/"
            $0.authBasic = ["access_token":"ACCESS_TOKEN"]
            $0.authHeader = "Authorization"
            $0.authTokenKey = "Github"
            
        }
    
    }
    
    func testUserNameRequest() {
        
        let expectation = self.expectationWithDescription(__FUNCTION__ + " asynchronous request")
        
        let githubAPI = GithubAPI.session
        
        // setup endpoint
        
        var profile = GithubAPI.Endpoints.UsersNamed.endpoint
        
        profile.pathpieces = ["username" : "joalbright"]
        
        // run request
        
        githubAPI.request(profile) {
            
            XCTAssertNil($0.error, __FUNCTION__ + " error \($0.error)")
            
            XCTAssertNotNil($0.info, __FUNCTION__ + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
    }
    
    func testSearchUsersRequest() {
        
        let expectation = self.expectationWithDescription(__FUNCTION__ + " asynchronous request")
        
        let githubAPI = GithubAPI.session
        
        // setup endpoint
        
        var profile = GithubAPI.Endpoints.SearchUsers.endpoint
        
        profile.parameters = ["q" : "joalbright"]
        
        // run request
        
        githubAPI.request(profile) {
            
            XCTAssertNil($0.error, __FUNCTION__ + " error \($0.error)")
            
            XCTAssertNotNil($0.info, __FUNCTION__ + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
    }
    
}

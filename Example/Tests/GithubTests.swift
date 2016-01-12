//
//  GithubTests.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Relax

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        GithubAPI.session.start {
            
            $0.authBasic["client_id"] = GITHUB_CLIENT_KEY
            $0.authBasic["client_secret"] = GITHUB_CLIENT_SECRET
            
        }
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserNameRequest() {
        
        let expectation = self.expectationWithDescription(__FUNCTION__ + " asynchronous request")
        
        let githubAPI = GithubAPI.session
        
        // setup endpoint
        
        var profile = GithubAPI.Endpoints.UserName.endpoint
        
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
        
        profile.pathpieces = ["q" : "joalbright"]
        
        // run request
        
        githubAPI.request(profile) {
            
            XCTAssertNil($0.error, __FUNCTION__ + " error \($0.error)")
            
            XCTAssertNotNil($0.info, __FUNCTION__ + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
    }
    
}

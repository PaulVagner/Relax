//
//  GithubTests.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Relax

class GitHubTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        GitHubAPI.session().start()
    
    }
    
    func testUserNameRequest() {
        
        let expectation = self.expectationWithDescription(__FUNCTION__ + " asynchronous request")
        
        let session = GitHubAPI.session
        
        // setup endpoint
        
        var profile = GitHubAPI.Endpoints.UsersNamed.endpoint
        
        profile.pathpieces = ["username" : "joalbright"]
        
        // run request
        
        session().request(profile) {
            
            XCTAssertNil($0.error, __FUNCTION__ + " error \($0.error)")
            
            XCTAssertNotNil($0.info, __FUNCTION__ + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
    }
    
    func testSearchUsersRequest() {
        
        let expectation = self.expectationWithDescription(__FUNCTION__ + " asynchronous request")
        
        let githubAPI = GitHubAPI.session
        
        // setup endpoint
        
        var profile = GitHubAPI.Endpoints.SearchUsers.endpoint
        
        profile.parameters = ["q" : "joalbright"]
        
        // run request
        
        githubAPI().request(profile) {
            
            XCTAssertNil($0.error, __FUNCTION__ + " error \($0.error)")
            
            XCTAssertNotNil($0.info, __FUNCTION__ + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
    }
    
}

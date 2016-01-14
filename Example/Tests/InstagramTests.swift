//
//  InstagramTests.swift
//  Relax
//
//  Created by Jo Albright on 1/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

class InstagramTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        InstagramAPI.session.start {
            
            $0.authBasic["client_id"] = FOURSQUARE_CLIENT_KEY
            $0.authBasic["client_secret"] = FOURSQUARE_CLIENT_SECRET
            
            $0.baseURL = "https://api.instagram.com/v1/"
            $0.authURL = "https://api.instagram.com/oauth/"
            $0.authBasic = ["access_token":"ACCESS_TOKEN"]
            $0.authHeader = "Authorization"
            $0.authTokenKey = "Instagram"
        
            
            
        }
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}

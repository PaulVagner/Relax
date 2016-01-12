//
//  GithubTests.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Relax

//client_id=CLIENT_ID&client_secret=CLIENT_SECRET

class FoursquareTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        FoursquareAPI.session.start {
            
            $0.authBasic["client_id"] = FOURSQUARE_CLIENT_KEY
            $0.authBasic["client_secret"] = FOURSQUARE_CLIENT_SECRET
            $0.authBasic["v"] = "20160112"
            
        }
        
    }
    
    func testVenuesSearchRequest() {
        
        let expectation = self.expectationWithDescription(__FUNCTION__ + " asynchronous request")
        
        let foursquareAPI = FoursquareAPI.session
        
        // setup endpoint
        
        var atlanta = FoursquareAPI.Endpoints.VenuesSearch.endpoint
        
        atlanta.parameters = ["near": "atlanta", "query": "coffee"]
        
        // run request
        
        foursquareAPI.request(atlanta) {
            
            XCTAssertNil($0.error, __FUNCTION__ + " error \($0.error)")
            
            XCTAssertNotNil($0.info, __FUNCTION__ + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
    }
    
}

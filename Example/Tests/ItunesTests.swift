//
//  ItunesTests.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Relax

class ItunesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchRequest() {
        
        let expectation = self.expectationWithDescription(__FUNCTION__ + " asynchronous request")
        
        // singleton Itunes API
        
        let itunesAPI = ItunesAPI.session
        
        // setup endpoint
        
        var search = ItunesAPI.Endpoints.Search.endpoint
        
        search.parameters = ["term" : "daft+punk"]
        
        // run request
        
        itunesAPI.request(search) {
            
            XCTAssertNil($0.error, __FUNCTION__ + " error \($0.error)")
            
            XCTAssertNotNil($0.info, __FUNCTION__ + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
    }
    
    func testLookupRequest() {
        
        let expectation = self.expectationWithDescription(__FUNCTION__ + " asynchronous request")
        
        // singleton Itunes API
        
        let itunesAPI = ItunesAPI.session
        
        // setup endpoint
        
        var search = ItunesAPI.Endpoints.Lookup.endpoint
        
        search.parameters = ["id" : "5468295"]
        
        // run request
        
        itunesAPI.request(search) {
            
            XCTAssertNil($0.error, __FUNCTION__ + " error \($0.error)")
            
            XCTAssertNotNil($0.info, __FUNCTION__ + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectationsWithTimeout(10, handler: nil)
        
    }
    
}

//
//  ItunesAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation
import Relax


// Documentation : https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html

private let _i = ItunesAPI()

public class ItunesAPI: API {
    
    public override class func session() -> ItunesAPI { return _i }
    
    public override func start() {
        
        baseURL = "https://itunes.apple.com/"
        
    }

    public enum Endpoints: String {
        
        /// Search using "term" parameter
        case Search
        
        /// Lookup entity (artist, album, etc) using "id" (or another) parameter
        case Lookup
        
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                .Search : Endpoint(path: "search"),
                .Lookup : Endpoint(path: "lookup")
                
            ]
            
        }
        
    }
    
}
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

public class ItunesAPI: StarterAPI {
    
    public enum Endpoints: String {
        
        case Search, Lookup
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                .Search : Endpoint(path: "search"),
                .Lookup : Endpoint(path: "lookup")
                
            ]
            
        }
        
    }
    
}
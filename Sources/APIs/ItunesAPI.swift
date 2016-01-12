//
//  ItunesAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation


// Documentation : https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html

public struct ItunesAPI: API {
    
    public var baseURL: String = "https://itunes.apple.com/"
    
    public var clientKey: String?
    public var clientSecret: String?
    public var authHeader: String?
    
    public var token: String? {
        
        get { return load("ItunesToken") }
        set { save("ItunesToken",newValue) }
        
    }
    
    enum Endpoints: String {
        
        case Search, Lookup
        
        var raw: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                .Search : Endpoint(path: "search", method: .GET),
                .Lookup : Endpoint(path: "lookup", method: .GET)
                
            ]
            
        }
        
    }
    
}
//
//  ItunesAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation


// Documentation : https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html

public class ItunesAPI: StarterAPI, API {
    
    public static var session = ItunesAPI()
    
    public var baseURL: String = "https://itunes.apple.com/"
    
    public var authBasic: [String:String] = [:]
    public var authHeader: String = ""
    public var authToken: String {
        
        get { return load("ItunesToken") ?? "" }
        set { save("ItunesToken",newValue) }
        
    }
    
    public enum Endpoints: String {
        
        case Search, Lookup
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                .Search : Endpoint(path: "search", method: .GET),
                .Lookup : Endpoint(path: "lookup", method: .GET)
                
            ]
            
        }
        
    }
    
}
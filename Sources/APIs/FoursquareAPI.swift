//
//  FoursquareAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation


// Documentation : https://developer.foursquare.com

public class FoursquareAPI: StarterAPI, API {
    
    public static var session = FoursquareAPI()
    
    public var baseURL: String = "https://api.foursquare.com/v2/"
    
    public var authBasic: [String:String] = [:]
    public var authHeader: String = "Authorization"
    public var authToken: String {
        
        get { return load("FoursquareToken") ?? "" }
        set { save("FoursquareToken",newValue) }
        
    }
    
    public enum Endpoints: String {
        
        case VenuesExplore, VenuesSearch
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                .VenuesExplore : Endpoint(path: "venues/explore", method: .GET),
                .VenuesSearch : Endpoint(path: "venues/search", method: .GET)
                
            ]
            
        }
        
    }
    
}
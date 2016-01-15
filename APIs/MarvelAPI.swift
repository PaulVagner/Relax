//
//  MarvelAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation
import Relax


// Documentation : http://developer.marvel.com

public class MarvelAPI: API {
    
    public enum Endpoints: String {
        
        case PLACEHOLDER
        
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .PLACEHOLDER : Endpoint(path: "PLACEHOLDER")
                
                
            ]
            
        }
        
    }
    
}
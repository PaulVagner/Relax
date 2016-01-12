//
//  API.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//
//


import Foundation
import Inlinit


public protocol API: Defaultable, Inlinit {
    
    var baseURL: String { get set }
    
    var authBasic: [String:String] { get set }
    var authHeader: String { get set }
    var authToken: String { get set }
    
}

extension API {
    
    public mutating func start(@noescape c: inout Self -> Void) -> Self {
        
        c(&self); return self
        
    }
    
    public func request(endpoint: Endpoint, response: Response) {
        
        Relax.request(endpoint, response: response, api: self)
        
    }
    
}

public class StarterAPI {
    
    public required init() { }
    
}




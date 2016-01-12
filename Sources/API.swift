//
//  API.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//
//


import Foundation


public protocol API: Defaultable {

    var baseURL: String { get set }
    
    var clientKey: String? { get set }
    var clientSecret: String? { get set }
    
    var authHeader: String? { get set }
    var token: String? { get set }
    
}




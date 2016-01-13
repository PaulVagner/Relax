//
//  Defaultable.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//
//


import Foundation


private let _d = NSUserDefaults.standardUserDefaults()

public protocol Defaultable { }

extension Defaultable {
    
    public func load<T>(k: String) -> T? { return _d.objectForKey(k) as? T }
    public func save<T>(k: String, _ v: T) { _d.setObject(v as? AnyObject, forKey: k) }
    
}
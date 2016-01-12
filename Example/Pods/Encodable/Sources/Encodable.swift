//
//  Encodable.swift
//  Encodable
//
//  Created by Jo Albright on 1/1/16.
//  Copyright © 2016 Jo Albright. All rights reserved.
//

import Foundation
import Inlinit

public typealias EncodedInfo = [String:AnyObject]

public protocol Encodable: Inlinit {
    
    init(_:EncodedInfo)
    
}

extension Encodable {
    
    func encode() -> EncodedInfo {
        
        return EncodedInfo {
            
            for c in Mirror(reflecting: self).children {
                
                guard let label = c.label else { continue }
                c.value --> $0[label]
                
            }
            
        }
        
    }
    
}

infix operator <-- {}
infix operator --> {}

// MARK: Encodable - Operators

public func <-- <T:Encodable>(inout left:T?, right: AnyObject?) { left = T(right as? EncodedInfo ?? [:]) }
public func --> <T:Encodable>(left:T?, inout right: AnyObject?) { right = left?.encode() }

public func <-- <T:Encodable>(inout left:T, right: AnyObject?) { left = T(right as? EncodedInfo ?? [:]) }
public func --> <T:Encodable>(left:T, inout right: AnyObject?) { right = left.encode() }

// MARK: Encodable - Array Operators

public func <-- <T:Encodable>(inout left:[T], right: AnyObject?) { left = (right as? [EncodedInfo])?.decode() ?? [] }
public func --> <T:Encodable>(left:[T], inout right: AnyObject?) { right = left.encode() }

// MARK: Encodable - Basic Type Operators

public func <-- <T>(inout left:T?, right: AnyObject?) { left = right as? T }
public func --> <T>(left:T?, inout right: AnyObject?) { right = left as? AnyObject }

public func <-- <T>(inout left:T, right: AnyObject?) { left = right as! T }
public func --> <T>(left:T, inout right: AnyObject?) { right = left as? AnyObject }

// MARK: Encodable - Extensions

public extension Array where Element: Encodable {
    
    public func encode() -> [EncodedInfo] {
        
        return [EncodedInfo] { for item in self { $0.append(item.encode()) } }
        
    }
    
}

public extension CollectionType where Generator.Element == EncodedInfo {
    
    public func decode<T:Encodable>() -> [T] {
        
        return [T] { for item in self { $0.append(T(item)) } }
        
    }
    
}


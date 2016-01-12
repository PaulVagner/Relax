//
//  Serializable.swift
//  Encodable
//
//  Created by Jo Albright on 1/9/16.
//
//

import Foundation

// MARK: Serializable

public enum SerializeError: ErrorType { case NotSerializable }

public protocol Serializable { }

extension Serializable {
    
    public func serialize(object: AnyObject? = nil) throws -> NSData {
        
        guard let object = object ?? self as? AnyObject else { throw SerializeError.NotSerializable }
        
        var data: NSData
        
        do {  data = try NSJSONSerialization.dataWithJSONObject(object, options: .PrettyPrinted)
            
        } catch { throw error }
        
        return data
        
    }
    
}

extension Array: Serializable { }
extension Dictionary: Serializable { }

// MARK: Unserializable

public enum UnserializeError: ErrorType { case NotUnserializable }

public protocol Unserializable { }

extension Unserializable {

    public func unserialize(data: NSData? = nil) throws -> AnyObject {
        
        guard let data = data ?? self as? NSData else { throw UnserializeError.NotUnserializable }
        
        var object: AnyObject
        
        do {  object = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            
        } catch { throw error }
        
        return object
        
    }
    
}

extension NSData: Unserializable { }




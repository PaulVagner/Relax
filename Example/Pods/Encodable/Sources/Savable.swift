//
//  Savable.swift
//  Encodable
//
//  Created by Jo Albright on 1/6/16.
//
//

import Foundation

private let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first

public protocol Saveable { }

extension Saveable {
    
    public func save(name: String, info: AnyObject?) {
        
        guard let info = info else { return }
        guard let path = documentDirectory?.stringByAppendingString("/" + name) else { return }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            
            NSKeyedArchiver.archiveRootObject(info, toFile: path)
            
        }
        
    }
    
    public func load(name: String, completion: (AnyObject?) -> ()) {
        
        guard let path = documentDirectory?.stringByAppendingString("/" + name) else { return }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            
            let data = NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            
            dispatch_async(dispatch_get_main_queue(), {
                
                completion(data)
                
            })
            
        }
        
    }
    
}
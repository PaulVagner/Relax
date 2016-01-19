//
//  UberAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation
import Relax


// Documentation : https://developer.uber.com

public class UberAPI: StarterAPI {
    
    public enum Endpoints: String {
        
        // Auth
        
        case Auth, AuthCode
        
        // Products
        /// List Products
        case Products
        
        /// Get Product Details
        case ProductId
        
        // Estimates
        /// Get Price Estimates
        case EstimatePrice
        
        /// Get Time Estimates
        case EstimateTime
        
        // User
//        /// Get User History -> uses endpoint "/v1.2/extension" all others use "/v1/extension"
//        case UserHistory
        
        /// Get User Info
        case UserInfo
        
        // Requests
        /// Create Ride Request
        case CreateRideRequest
        
        /// Get Ride Details
        case GetRideDetails
        
        /// Get Ride? Estimate
        case GetRideEstimate
        
        /// Cancel Ride Request
        case CancelRideRequest
        
        /// Get Tracking Map
        case GetTrackingMap
        
        /// Get Receipt
        case GetRideReceipt
        
        // Reminders
        /// Create Ride Reminder
        case CreateRideReminder
        
        /// Get Ride Reminder Details
        case GetReminderDetails
        
        /// Update Ride Reminder Details
        case UpdateReminderDetails
        
        /// Cancel Ride Reminder
        case CancelReminder
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .Auth : Endpoint(path: "authenticate", requiredParameters: ["client_id","response_type","redirect_uri"]),
                .AuthCode : Endpoint(path: "access_token", requiredParameters: ["client_id","client_secret","grant_type","redirect_uri","code"]),
                
                
                // Products
                .Products : Endpoint(path: "products", requiresUser: true),
                .ProductId : Endpoint(path: "products/:product_id", requiresUser: true)
                
                
                // Estimates
                .EstimatePrice : Endpoint(path: "estimates/price", requiresUser: true),
                .EstimateTime : Endpoint(path: "estimates/time", requiresUser: true)
                
                // User
//                .UserHistory : Endpoint(path: "history", requiresUser: true),
                .UserInfo: Endpoint(path: "me", requiresUser: true)
                
                // Requests
                .CreateRideRequest : Endpoint(path: "requests", method: .POST, requiresUser: true),
                .GetRideDetails : Endpoint(path: "requests/:request_id", requiresUser: true)
                .GetRideEstimate : Endpoint(path: "requests/estimate", method: .POST, requiresUser: true)
                .CancelRideRequest : Endpoint(path: "requests/:request_id", method: .DELETE, requiresUser: true)
                .GetTrackingMap : Endpoint(path: "requests/:request_id/map", requiresUser: true)
                .GetRideReceipt : Endpoint(path: "requests/:request_id/receipts", requiresUser: true)
                
                // Reminders
                .CreateRideReinder : Endpoint(path: "reminders", method: .POST, requiresUser: true)
                .GetReminderDetails : Endpoint(path: "reminders/:reminder_id", requiresUser: true)
                .UpdateReminderDetails : Endpoint(path: "reminders/:reminder_id", method: .PATCH, requiresUser: true)
                .CancelReminder : Endpoint(path: "reminders/:reminder_id", method: .DELETE, requiresUser: true)
            ]
            
        }
        
    }
    
}

public class UberAPI_1_2: StarterAPI {
    
    public enum Endpoints: String {
    
        // User
        /// Get User History -> uses endpoint "/v1.2/extension" all others use "/v1/extension"
        case UserHistory
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
        
                // User
                .UserHistory : Endpoint(path: "history", requiresUser: true)
            ]
            
            
    }
}




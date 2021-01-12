//
//  NexmoIncomingCallHandler.swift
//
//
//  Created by Tayler Moosa on 12/14/20.
//

import Foundation
import Vapor

/**
 Use NexmoIncomingCallHandler to return data describing the incoming call
 
 incomingNumber: The number of the party dialing in
 
 conversationUuid: The unique ID for this Call.
 
 to: The number the incoming caller is dialing
 */

public struct NexmoIncomingCallHandler {
     let request                    : Request
     public var incomingCallData    : IncomingCall? {
        let content = try? request.query.decode(IncomingCall.self)
        return content
    }
    public var from      : Int? {
        let content = try? request.query.decode(IncomingCall.self)
        return content?.from
    }
    
    public var conversationUuid    : String? {
        let content = try? request.query.decode(IncomingCall.self)
        return content?.conversation_uuid
    }
    
    public var to                : String? {
        let content = try? request.query.decode(IncomingCall.self)
        return content?.to
    }
    
    public var uuid : String? {
        let content = try? request.query.decode(IncomingCall.self)
        return content?.uuid
    }
    
    public init(request: Request) {
        self.request = request
    }
    
    public func createNexmoDestinationURL(baseURL: String, endpoint: String, additionalQueryParams: [NexmoQueryParam] = []) -> String {
        var finalEndpoint: String
        if baseURL.last == "/" && endpoint.first == "/" {
            finalEndpoint = String(endpoint.dropFirst())
        } else if baseURL.last != "/" && endpoint.first != "/" {
            finalEndpoint = "/\(endpoint)"
        } else {
            finalEndpoint = endpoint
        }
        guard let incomingNumber    = from else {
            print("failed at incomingNumber")
            return baseURL + finalEndpoint }
        guard let destinationNumber = to else {
            print("failed at destinationNumber")
            return  baseURL + finalEndpoint  }
        guard let conversationUuid  = conversationUuid else {
            print("failed at conversationUUID")
            return  baseURL + finalEndpoint }
        guard let uuid = uuid else {
            print("failed at uuid")
            return baseURL + finalEndpoint
        }
        var url = baseURL + finalEndpoint + "?from=\(incomingNumber)&conversation_uuid=\(conversationUuid)&to=\(destinationNumber)&uuid=\(uuid)"
        for x in additionalQueryParams {
            url += "&\(x.param)"
        }
        return url
    }
}


public struct IncomingCall: Content {
    public let from                : Int
    public let conversation_uuid   : String
    public let to                  : String
    public let uuid                : String
}

/**
 Creates a Key=Value param to pass to a subsequent endpoint.
 */
public struct NexmoQueryParam {
    let param: String
    
    init(key: String, value: Any) {
        param = "\(key)=\(value)"
    }
}

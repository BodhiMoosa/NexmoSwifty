//
//  File.swift
//  
//
//  Created by Tayler Moosa on 12/31/20.
//

import Foundation

/**
 Conect - Nexmo Call Control Object
 
 
 */
public class NexmoConnect: NexmoAction {
    let eventURL    : [String]
    let timeout     : Int
    let from        : String
    let endpoint    : [Endpoint]
    
    enum CodingKeys: String, CodingKey {
        case eventURL = "eventUrl"
        case action, timeout, from, endpoint
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventURL, forKey: .eventURL)
        try container.encode(timeout, forKey: .timeout)
        try container.encode(from, forKey: .from)
        try container.encode(endpoint, forKey: .endpoint)
    }
    
    public  init(from: String, eventURL: String, timeout: Int, endpoint: Endpoint) {
        self.from       = from
        self.eventURL   = [eventURL]
        self.timeout    = timeout
        self.endpoint   = [endpoint]
        super.init(action: .connect)
    }
    
    required init(from decoder: Decoder) throws { fatalError("init(from:) has not been implemented") }
}

public enum NexmoEndpointTypes: String {
    case phone  = "phone"
    case vbc    = "vbc"
}
public struct Endpoint: Codable {
    let type                    : String
    let dtmfAnswer, number, ext : String?
    
    public init(phoneEndpointNumber: String, phoneEndpointDTMFAnswer: String? = nil) {
        type        = "phone"
        number      = phoneEndpointNumber
        dtmfAnswer  = phoneEndpointDTMFAnswer
        ext         = nil
    }
    
    public init(vbcExtension: String) {
        type        = "vbc"
        number      = nil
        dtmfAnswer  = nil
        ext         = vbcExtension
    }
}

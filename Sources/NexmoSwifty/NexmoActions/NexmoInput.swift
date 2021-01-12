// 
//  NexmoInput.swift
//
//
//  Created by Tayler Moosa on 12/14/20.
//

import Foundation
import Vapor
/**
 Creates a NexmoInput Object
 
 Use dtmf to define the maximum number of digits allowed, the timout limit (seconds), and whether the user can submit their selection with #.
 Use speech to define an optional speech recognition input.
 */
public class NexmoInput: NexmoAction {
    public let eventUrl: [String]
    public let dtmf    : DtmfInput
    
    
    public init(eventUrl: String, dtmf: DtmfInput) {
        self.eventUrl   = [eventUrl]
        self.dtmf       = dtmf
        super.init(action: .input)
    }
    
    private enum CodingKeys: String, CodingKey {
        case eventUrl, dtmf, speech
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventUrl, forKey: .eventUrl)
        try container.encode(dtmf, forKey: .dtmf)
    }
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

public struct DtmfInput: Codable {
    public let maxDigits       : Int
    public let timeOut         : Int
    public let submitOnHash    : Bool
    
    public init(maxDigits: Int, timeOut: Int, submitOnHash: Bool) {
        self.maxDigits      = maxDigits
        self.timeOut        = timeOut
        self.submitOnHash   = submitOnHash
    }
}


public struct DtmfResponse: Content {
    public let dtmf                : DtmfDigitsObject
    public let from                : String
    public let to                  : String
    public let uuid                : String
    public let conversation_uuid   : String
    public let timestamp           : String
    
    public init(dtmf: DtmfDigitsObject, from: String, to: String, uuid: String, conversation_uuid: String, timestamp: String) {
        self.dtmf               = dtmf
        self.from               = from
        self.to                 = to
        self.uuid               = uuid
        self.conversation_uuid  = conversation_uuid
        self.timestamp          = timestamp
    }
    
}

public struct DtmfDigitsObject: Content {
    public let digits          : String
    public let timed_out       : Bool
    
    public init(digits: String, timed_out: Bool) {
        self.digits     = digits
        self.timed_out  = timed_out
    }
}

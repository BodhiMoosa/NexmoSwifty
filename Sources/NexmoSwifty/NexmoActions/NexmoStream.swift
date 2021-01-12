// 
//  NexmoStream.swift
//
//
//  Created by Tayler Moosa on 12/14/20.
//

import Foundation

/**
 Streams audio into call
 
 If bargeIn == True, NexmoObject array must end with NexmoInput or NexmoSpeech
 */
public class NexmoStream: NexmoAction {
    let streamUrl   : [String]
    let level       : Float
    let bargeIn     : Bool
    let loop        : Int
    
    public init(streamUrl: String, level: Float = 1, bargeIn: Bool = false, loop: Int = 1) {
        self.streamUrl  = [streamUrl]
        self.level      = level
        self.bargeIn    = bargeIn
        self.loop       = loop
        super.init(action: .stream)
    }
    
    private enum CodingKeys : String, CodingKey {
        case streamUrl, bargeIn, loop, level
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(streamUrl, forKey: .streamUrl)
        try container.encode(bargeIn, forKey: .bargeIn)
        try container.encode(loop, forKey: .loop)
        try container.encode(level, forKey: .level)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

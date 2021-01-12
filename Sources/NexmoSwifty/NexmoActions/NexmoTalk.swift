//
//  v0.1.1
//
// Nexmotalk.swift
//  Created by Tayler Moosa on 12/14/20.
//

import Foundation

/**
 Creates a TTS object
 
 If bargeIn == True, the final NexmoAction in the array must be a NexmoInput object.
 */
public class NexmoTalk: NexmoAction {
    let text            : String
    let bargeIn         : Bool
    let loop            : Int
    let volume          : Float
    let voice           : String?
    public init(text: String, bargeIn: Bool, loop: Int = 1, volume: Float = 1, voice: String? = nil) {
        self.text       = text
        self.bargeIn    = bargeIn
        self.loop       = loop
        self.volume     = volume
        self.voice      = voice
        super.init(action: .talk)
    }
    
    private enum CodingKeys : String, CodingKey {
        case text, bargeIn, loop, volume, voice
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(bargeIn, forKey: .bargeIn)
        try container.encode(loop, forKey: .loop)
        try container.encode(volume, forKey: .volume)
        try container.encodeIfPresent(voice, forKey: .voice)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

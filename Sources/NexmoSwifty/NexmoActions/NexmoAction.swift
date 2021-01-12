// 
//  NexmoAction.swift
//
//
//  Created by Tayler Moosa on 12/14/20.
//

import Foundation

public class NexmoAction: Codable {
    public let action : String
    init(action: NexmoActions) {
        self.action = action.rawValue
    }
    
    private enum CodingKeys: String, CodingKey {
        case action
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(action, forKey: .action)
    }
}

extension NexmoAction {
    public func encodeNexmoObject()-> String {
        guard let data      = try? JSONEncoder().encode([self]) else { return "fail" }
        guard let stringy   = String(data: data, encoding: .utf8) else { return "fail" }
        return stringy
    }
}

public enum NexmoActions: String {
    case action     = "action"
    case stream     = "stream"
    case input      = "input"
    case talk       = "talk"
    case connect    = "connect"
    case record     = "record"
}

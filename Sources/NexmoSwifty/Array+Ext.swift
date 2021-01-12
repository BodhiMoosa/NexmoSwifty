//
//  Array+Ext.swift
//  
//
//  Created by Tayler Moosa on 12/21/20.
//

import Foundation

extension Array where Element: NexmoAction {
    public func encodeNexmoArray() -> String {
        guard let encoded = try? JSONEncoder().encode(self) else { return "error" }
        return String(data: encoded, encoding: .utf8) ?? "error"
    }
}

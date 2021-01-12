//
//  CustomErrors.swift
//  NexmoSwifty
//
//  Created by Tayler Moosa on 12/30/20.
//

import Foundation

import Foundation

public enum CustomErrors: String, Error {
    case errorError         = "Returned with Error"
    case responseError      = "Response Error"
    case directoryError     = "Error creating directory"
    case documentsURLError  = "documentsURLError"
    case statusError        = "statusError"
    case fileURLError       = "fileURLError"
    case savedURLError      = "savedURLError"
    case initialURLError    = "initialURLError"
    
    
}

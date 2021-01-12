//
//  File.swift
//  
//
//  Created by Tayler Moosa on 12/30/20.
//

import Foundation
import Vapor
import JWTKit
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public class NexmoRecord: NexmoAction {
    let eventUrl        : [String]
    let timeOut         : Int
    let endOnSilence    : Int
    let beepStart       : Bool
    
    public init(eventUrl: String, timeOut: Int, endOnSilence: Int, beepStart: Bool) {
        self.eventUrl       = [eventUrl]
        self.timeOut        = timeOut
        self.endOnSilence   = endOnSilence
        self.beepStart      = beepStart
        super.init(action: .record)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    private enum CodingKeys : String, CodingKey {
        case eventUrl, timeOut, endOnSilence, beepStart
        
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventUrl, forKey: .eventUrl)
        try container.encode(beepStart, forKey: .beepStart)
        try container.encode(timeOut, forKey: .timeOut)
        try container.encode(endOnSilence, forKey: .endOnSilence)
    }
}


public class NexmoRecordingHandler {
    let privateKey      : String
    let applicationID   : String
    let req             : Request
    
    public var callData : IncomingCall? {
        let content = try? req.query.decode(IncomingCall.self)
        return content
    }
    
    public init(privateKey: String, applicationID: String, request: Request) {
        self.privateKey     = privateKey
        self.applicationID  = applicationID
        self.req            = request
    }
    
    public func getToken() -> String? {
        let signers = JWTSigners()
            do {
                try signers.use(.rs256(key: .private(pem: privateKey)))
            } catch { return nil }
            guard let jwt = try? signers.sign(JWTPayloadObject(jti: .init(value: String(NSDate().timeIntervalSince1970)) , application_id: applicationID, iat: .init(value: Date()))) else {
                return nil
            }
            return jwt
    }
    public func getNexmoRecording() -> EventLoopFuture<Data> {
        let promise                     = req.eventLoop.makePromise(of: Data.self)
        guard let receivedRecordingData = try? req.content.decode(ReceivedRecordingData.self) else {
            promise.fail(CustomErrors.initialURLError)
            return promise.futureResult
        }
        guard let recordingUrlString = receivedRecordingData.recordingURL else {
            promise.fail(CustomErrors.initialURLError)
            return promise.futureResult
        }
        guard let recordingUrl = URL(string: recordingUrlString) else {
            promise.fail(CustomErrors.directoryError)
            return promise.futureResult
        }
        
        var request = URLRequest(url: recordingUrl)
        request.httpMethod = "GET"
        guard let token = getToken() else {
            promise.fail(CustomErrors.initialURLError)
            return promise.futureResult
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.downloadTask(with: request) { url, response, error in
            if let error = error {
                promise.fail(error)
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                promise.fail(CustomErrors.responseError)
                return
            }
            guard let url = url else { return }
            do {
                let imageData = try Data(contentsOf: url)
                promise.succeed(imageData)
            } catch let error {
                promise.fail(error)
                return
            }
        }
        task.resume()
        return promise.futureResult
    }
    
}

public struct ReceivedRecordingData: Codable {
    let startTime       : Date?
    let recordingURL    : String?
    let size            : Int?
    let recordingUUID   : String?
    let endTime         : Date?
    let conversationUUID: String?
    let timestamp       : String?

    enum CodingKeys: String, CodingKey {
        case size
        case timestamp
        case startTime          = "start_time"
        case recordingURL       = "recording_url"
        case recordingUUID      = "recording_uuid"
        case endTime            = "end_time"
        case conversationUUID   = "conversation_uuid"
    }
}

// defines criteria for token
public struct JWTPayloadObject : JWTPayload, Equatable {
    public func verify(using signer: JWTSigner) throws { }
    var jti             : IDClaim
    var application_id  : String
    var iat             : IssuedAtClaim
}


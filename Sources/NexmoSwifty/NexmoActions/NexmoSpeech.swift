// 
//  NexmoSpeech.swift
//
//
//  Created by Tayler Moosa on 12/20/20.
//

import Foundation
// MARK: - Speech

/**
 Captures incoming caller's speech and converts to text
 
 eventURL must be POST
 
 Default language is American English
 */
public class NexmoSpeech: NexmoAction {
    let eventURL    : [String]
    let eventMethod : String
    let type        : [String]
    let speech      : SpeechClass
    
    public init(eventURL: String, wordsToLookFor: [String], language: Languages = .English_UnitedStates) {
        self.eventURL       = [eventURL]
        self.eventMethod    = "POST"
        self.type           = ["speech"]
        self.speech         = SpeechClass(language: language, context: wordsToLookFor)
        super.init(action: .input)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    enum CodingKeys: String, CodingKey {
        case eventURL = "eventUrl"
        case eventMethod, type, speech
    }
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventURL, forKey: .eventURL)
        try container.encode(eventMethod, forKey: .eventMethod)
        try container.encode(type, forKey: .type)
        try container.encode(speech, forKey: .speech)
    }
}

// MARK: - SpeechClass
struct SpeechClass: Codable {
    public let language    : Languages.RawValue
    public let context     : [String]
    init(language: Languages = Languages.English_UnitedStates, context: [String]) {
        self.language = language.rawValue
        self.context = context
    }
}

public enum Languages: String, Codable {
    
    case     Afrikaans_SouthAfrica      = "af-ZA"
    case     Albanian_Albania      = "sq-AL"
    case     Amharic_Ethiopia      = "am-ET"
    case     Arabic_Algeria      = "ar-DZ"
    case     Arabic_Bahrain      = "ar-BH"
    case     Arabic_Egypt      = "ar-EG"
    case     Arabic_Iraq      = "ar-IQ"
    case     Arabic_Israel      = "ar-IL"
    case     Arabic_Jordan      = "ar-JO"
    case     Arabic_Kuwait      = "ar-KW"
    case     Arabic_Lebanon      = "ar-LB"
    case     Arabic_Morocco      = "ar-MA"
    case     Arabic_Oman      = "ar-OM"
    case     Arabic_Qatar      = "ar-QA"
    case     Arabic_SaudiArabia      = "ar-SA"
    case     Arabic_StateofPalestine      = "ar-PS"
    case     Arabic_Tunisia      = "ar-TN"
    case     Arabic_UnitedArabEmirates      = "ar-AE"
    case     Armenian_Armenia      = "hy-AM"
    case     Azerbaijani_Azerbaijan      = "az-AZ"
    case     Basque_Spain      = "eu-ES"
    case     Bengali_Bangladesh      = "bn-BD"
    case     Bengali_India      = "bn-IN"
    case     Bulgarian_Bulgaria      = "bg-BG"
    case     Catalan_Spain      = "ca-ES"
    case     Croatian_Croatia      = "hr-HR"
    case     Czech_CzechRepublic      = "cs-CZ"
    case     Danish_Denmark      = "da-DK"
    case     Dutch_Netherlands      = "nl-NL"
    case     English_Australia      = "en-AU"
    case     English_Canada      = "en-CA"
    case     English_Ghana      = "en-GH"
    case     English_India      = "en-IN"
    case     English_Ireland      = "en-IE"
    case     English_Kenya      = "en-KE"
    case     English_NewZealand      = "en-NZ"
    case     English_Nigeria      = "en-NG"
    case     English_Philippines      = "en-PH"
    case     English_SouthAfrica      = "en-ZA"
    case     English_Tanzania      = "en-TZ"
    case     English_UnitedKingdom      = "en-GB"
    case     English_UnitedStates      = "en-US"
    case     Finnish_Finland      = "fi-FI"
    case     French_Canada      = "fr-CA"
    case     French_France      = "fr-FR"
    case     Galician_Spain      = "gl-ES"
    case     Georgian_Georgia      = "ka-GE"
    case     German_Germany      = "de-DE"
    case     Greek_Greece      = "el-GR"
    case     Gujarati_India      = "gu-IN"
    case     Hebrew_Israel      = "he-IL"
    case     Hindi_India      = "hi-IN"
    case     Hungarian_Hungary      = "hu-HU"
    case     Icelandic_Iceland      = "is-IS"
    case     Indonesian_Indonesia      = "id-ID"
    case     Italian_Italy      = "it-IT"
    case     Japanese_Japan      = "ja-JP"
    case     Javanese_Indonesia      = "jv-ID"
    case     Kannada_India      = "kn-IN"
    case     Khmer_Cambodia      = "km-KH"
    case     Korean_SouthKorea      = "ko-KR"
    case     Lao_Laos      = "lo-LA"
    case     Latvian_Latvia      = "lv-LV"
    case     Lithuanian_Lithuania      = "lt-LT"
    case     Malay_Malaysia      = "ms-MY"
    case     Malayalam_India      = "ml-IN"
    case     Marathi_India      = "mr-IN"
    case     Nepali_Nepal      = "ne-NP"
    case     NorwegianBokmål_Norway      = "nb-NO"
    case     Persian_Iran      = "fa-IR"
    case     Polish_Poland      = "pl-PL"
    case     Portuguese_Brazil      = "pt-BR"
    case     Portuguese_Portugal      = "pt-PT"
    case     Romanian_Romania      = "ro-RO"
    case     Russian_Russia      = "ru-RU"
    case     Serbian_Serbia      = "sr-RS"
    case     Sinhala_SriLanka      = "si-LK"
    case     Slovak_Slovakia      = "sk-SK"
    case     Slovenian_Slovenia      = "sl-SI"
    case     Spanish_Argentina      = "es-AR"
    case     Spanish_Bolivia      = "es-BO"
    case     Spanish_Chile      = "es-CL"
    case     Spanish_Colombia      = "es-CO"
    case     Spanish_CostaRica      = "es-CR"
    case     Spanish_DominicanRepublic      = "es-DO"
    case     Spanish_Ecuador      = "es-EC"
    case     Spanish_ElSalvador      = "es-SV"
    case     Spanish_Guatemala      = "es-GT"
    case     Spanish_Honduras      = "es-HN"
    case     Spanish_Mexico      = "es-MX"
    case     Spanish_Nicaragua      = "es-NI"
    case     Spanish_Panama      = "es-PA"
    case     Spanish_Paraguay      = "es-PY"
    case     Spanish_Peru      = "es-PE"
    case     Spanish_PuertoRico      = "es-PR"
    case     Spanish_Spain      = "es-ES"
    case     Spanish_UnitedStates      = "es-US"
    case     Spanish_Uruguay      = "es-UY"
    case     Spanish_Venezuela      = "es-VE"
    case     Sundanese_Indonesia      = "su-ID"
    case     Swahili_Kenya      = "sw-KE"
    case     Swahili_Tanzania      = "sw-TZ"
    case     Swedish_Sweden      = "sv-SE"
    case     Tamil_India      = "ta-IN"
    case     Tamil_Malaysia      = "ta-MY"
    case     Tamil_Singapore      = "ta-SG"
    case     Tamil_SriLanka      = "ta-LK"
    case     Telugu_India      = "te-IN"
    case     Thai_Thailand      = "th-TH"
    case     Turkish_Turkey      = "tr-TR"
    case     Ukrainian_Ukraine      = "uk-UA"
    case     Urdu_India      = "ur-IN"
    case     Urdu_Pakistan      = "ur-PK"
    case     Vietnamese_Vietnam      = "vi-VN"
    case     Zulu_SouthAfrica      = "zu-ZA"
}

// MARK: - SpeechResponse
public struct SpeechResponse: Codable {
    public let speech                              : ResultsResponse
    public let dtmf                                : DtmfSpeechResponse
    public let uuid, conversationUUID, timestamp   : String
    
    enum CodingKeys: String, CodingKey {
        case speech, dtmf, uuid
        case conversationUUID = "conversation_uuid"
        case timestamp
    }
    
    public init(speech: ResultsResponse, dtmf: DtmfSpeechResponse, uuid: String, conversationUUID: String, timestamp: String) {
        self.speech             = speech
        self.dtmf               = dtmf
        self.uuid               = uuid
        self.conversationUUID   = conversationUUID
        self.timestamp          = timestamp
    }
}

// MARK: - Dtmf
public struct DtmfSpeechResponse: Codable {
    public let digits: JSONNull?
    public let timedOut: Bool
    
    enum CodingKeys: String, CodingKey {
        case digits
        case timedOut = "timed_out"
    }
    
    public init(digits: JSONNull?, timedOut: Bool) {
        self.digits     = digits
        self.timedOut   = timedOut
    }
}

// MARK: - Speech
public struct ResultsResponse: Codable {
    public let timeoutReason   : String
    public let results         : [Results]
    
    enum CodingKeys: String, CodingKey {
        case timeoutReason = "timeout_reason"
        case results
    }
    
    public init(timeoutReason: String, results: [Results]) {
        self.timeoutReason  = timeoutReason
        self.results        = results
    }
}

// MARK: - Results
public struct Results: Codable {
    public let confidence, text: String
    
    public init(confidence: String, text: String) {
        self.confidence = confidence
        self.text       = text
    }
}

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

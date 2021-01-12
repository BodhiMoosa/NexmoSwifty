# NexmoSwifty
v1.0.0
A set of tools to work with Nexmo using Vapor 4

## Setup
Add the dependency to Package.swift:

~~~~swift
.package(url: "https://github.com/BodhiMoosa/NexmoSwifty.git", from: "1.0.0")
~~~~

And add the following to the targets:
~~~~swift
 .product(name: "NexmoSwifty", package: "NexmoSwifty")
~~~~


## Example
~~~~swift
let baseUrl = "www.exampleOfABaseUrl.com/"

func routes(_ app: Application) throws {
    app.get("answer") { req -> String in
        let handler             = NexmoIncomingCallHandler(request: req)
        let incomingNumber      = handler.incomingNumber
        let numberDialed        = handler.to
        let conversationUuid    = handler.conversationUuid
        let nextUrl             = handler.createNexmoDestinationURL(baseURL: baseUrl, endpoint: "hello")
        // nextUrl includes the destination endpoint and adds the incoming call data along with it.
        
        let array = [
            NexmoTalk(text: "Test out Nexmo's speech to text now! What's your favorite color?", bargeIn: true),
            NexmoSpeech(eventURL: nextUrl, wordsToLookFor: [
                "blue",
                "red",
                "green"
            ])
        ]
        
        return array.encodeNexmoArray()
    }

    app.post("hello") { req -> String in
        guard let response  = try? req.content.decode(SpeechResponse.self) else { return "fail"}
        let resultsArray    = response.speech.results
        // contains an array of text with associated confidence levels
        
        return NexmoTalk(text: "What a blast this test has been!", bargeIn: false).encodeNexmoObject()
    }
}
~~~~

Create text-to-speech greetings, stream audio files into the call flow, capture DTMF input, and transcribe incoming speech.

More Nexmo functionality will be added soon. 

Nexmo documentation: https://developer.nexmo.com/voice/voice-api/ncco-reference

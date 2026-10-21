//
//  Message.swift
//  EmailEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import Foundation
import SwiftData

@Model
class Message {
    var title: String
    var message: String
    var addresses: [String]
    var timestamp: Date

    init(
        title: String,
        message: String,
        addresses: [String],
        timestamp: Date = .now
    ) {
        self.title = title
        self.message = message
        self.addresses = addresses
        self.timestamp = timestamp
    }
}

extension Message {
    static let sample = sampleData[0]

    static let sampleData = [
        Message(
            title: "Example message",
            message: "Hello there!",
            addresses: ["ob1@force.com"]
        ),

        Message(
            title: "Reply",
            message: "General Kenobi!",
            addresses: ["grevious@force.com"]
        ),

        Message(
            title: "I hate you",
            message: "Master, I wanted to be the one to hunt him down!",
            addresses: ["ani@force.com"]
        ),

        Message(
            title: "Patience",
            message: "Rush, this do not. Calm, you should be.",
            addresses: ["green@force.com"]
        ),
    ]

}

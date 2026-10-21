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
            addresses: ["person@example.com"]
        )
    ]

}

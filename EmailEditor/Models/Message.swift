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
    var addresses: [Address]
    var timestamp: Date

    var emptyField: Bool {
        title.isEmpty || message.isEmpty || addresses.isEmpty
    }

    var allEmpty: Bool {
        title.isEmpty && message.isEmpty && addresses.isEmpty
    }

    init(
        title: String,
        message: String,
        addresses: [String],
        timestamp: Date = .now
    ) {
        self.title = title
        self.message = message
        self.addresses = addresses.map({ address in
            Address(address: address)
        })
        self.timestamp = timestamp
    }
}

extension Message {

    @Model
    class Address: Identifiable {
        var id: UUID
        var address: String

        init(id: UUID = UUID(), address: String) {
            self.id = id
            self.address = address
        }
    }

    static var emptyMessage: Message {
        Message(title: "", message: "", addresses: [])
    }

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
            addresses: ["grevious@force.com"],
            timestamp: .now.addingTimeInterval(-86400)
        ),

        Message(
            title: "I hate you",
            message: "Master, I wanted to be the one to hunt him down!",
            addresses: ["ani@force.com"],
            timestamp: .now.addingTimeInterval(-86400*2)
        ),

        Message(
            title: "Patience",
            message: "Rush, this do not. Calm, you should be.",
            addresses: ["green@force.com"],
            timestamp: .now.addingTimeInterval(-86400*3)
        ),
        Message(
            title: "I am the Senate",
            message: "If you were thinking of arresting me, I woudld reconsider",
            addresses: ["palp@senate.com"],
            timestamp: .now.addingTimeInterval(-86400*4)
        ),
        Message(
            title: "Senator 123",
            message: "I am still waiting at home, doing nothing",
            addresses: ["pad@senate.com"],
            timestamp: .now.addingTimeInterval(-86400*5)
        ),
        Message(
            title: "I'm tired of these mof- sith in this...",
            message: "It is over and you have lost",
            addresses: ["windy@force.com"],
            timestamp: .now.addingTimeInterval(-86400*6)
        ),
        Message(
            title: "Politics",
            message: "Meesa think that politics is mwya fun",
            addresses: ["jjar@senate.com"],
            timestamp: .now.addingTimeInterval(-86400*7)
        ),
    ]

}

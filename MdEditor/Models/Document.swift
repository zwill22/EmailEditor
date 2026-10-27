//
//  Document.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import Foundation
import SwiftData

func markdownToText(_ markdown: String) -> String {
    guard let attributed = try? AttributedString(markdown: markdown) else {
        return markdown
    }

    // Extract raw string
    return String(attributed.characters)
}

@Model
class Document {
    var content: String
    var timestamp: Date

    var addresses: [Address]
    var subject: String

    var start: String {
        let textRegex = Regex(pattern: ##"^([^#\n_>!`\*].+)$"##)

        if let groups = textRegex.extractFirst(inputString: content) {
            return markdownToText(groups[0])
        }

        if let substring = content.split(
            maxSplits: 1,
            whereSeparator: \.isNewline
        ).first {
            return markdownToText(String(substring))
        }

        return "Empty document"
    }

    var title: String {
        let titleRegex = Regex(pattern: ##"^# (.+)$"##)

        if let groups = titleRegex.extractFirst(inputString: content) {
            return markdownToText(groups[0])
        } else if !subject.isEmpty {
            return subject
        } else {
            return start
        }
    }

    init(
        content: String = "",
        addresses: [String] = [],
        subject: String = "",
        timestamp: Date = .now
    ) {
        self.content = content
        self.addresses = addresses.map({ address in
            Address(address: address)
        })
        self.subject = subject
        self.timestamp = timestamp
    }
}

extension Document {
    static let sample = sampleData[0]

    static let codeSample = sampleData[8]

    static let sampleData = [
        Document(
            content: """
                # Quick note

                *Let's be quick*, I am in a rush, so:

                - Don't worry
                - Be happy
                """,
            addresses: ["bmcferr@music.wrld"],
            subject: "Quick",
        ),

        Document(
            content: """
                # Notice of chaos

                On November 19, the world will stop working, possible reasons:

                1. A game
                2. Something else...
                """,
            addresses: ["mike@gta.sa", "trev@gta.sa", "frnk@gta.sa"],
            subject: "Chaos",
            timestamp: .now.addingTimeInterval(-86400)
        ),

        Document(
            content: """
                # Some nice code

                I found this great code snippet:

                ```cpp

                int main() {
                    return 0;
                }
                ```

                Isn't it great..
                """
            ,
            addresses: ["eln@moronx.com"],
            subject: "Code",
            timestamp: .now.addingTimeInterval(-86400 * 2)
        ),

        Document(
            content: """
                # Notice 

                Lt. PC has arrived. _Look after him_
                """,
            addresses: [
                "spck@ent.sf", "mccy@ent.sf", "uhr@ent.sf", "sctty@ent.sf",
                "rnd@xclsr.sf", "odo@dsn.bj", "ng@dfnt.sf",
            ],
            subject: "Sad",
            timestamp: .now.addingTimeInterval(-86400 * 3)
        ),
        Document(
            content: """
                # Rings

                I found these 20 rings lying around.
                Three are particularly beautiful with three big coloured gems.
                Seven are quite rustic, but still nice. 
                One is plain and unadorned, but the other nine are nice.

                I'm going to take them, I'm sure nothing bad will happen.

                > Insert quote here
                """,
            addresses: [
                "mgrth-fan@mddl.ea", "srn@eye.mrdr", "clbrmbr@hlln.ea",
            ],
            subject: "Rings",
            timestamp: .now.addingTimeInterval(-86400 * 4)
        ),
        Document(
            content: """
                # Syniad Gwych

                Dw i wedi cael syniad gwych.
                Dylech chi brynu clwb pel droed yng ngogledd Cymru. 
                """,
            addresses: ["r.mac@sunny.phl", "r.reyn@ddpl.com"],
            subject: "Syniad",
            timestamp: .now.addingTimeInterval(-86400 * 5)
        ),
        Document(
            content: """
                # Ideas for new apps

                - Markdown editor
                - Bus Tracker
                - Historic price/mass tracker

                Don't share these
                """,
            timestamp: .now.addingTimeInterval(-86400 * 6)
        ),
        Document(
            content: """
                # No try

                I can't decide whether to make this a reference to a certain short sci-fi figure,
                or to make it about rugby!
                """,
            addresses: ["green@temple.crscnt", "cym@rugby.wrld"],
            subject: "No try",
            timestamp: .now.addingTimeInterval(-86400 * 7)
        ),
        Document(
            content: """
                # Code examples

                C++

                ```cpp
                int add(const int x, const int y) {
                    return x + y;
                }
                ```

                Python

                ```python

                def subtract(x: int, y: int) -> int:
                    return x - y
                ```

                Rust

                ```rust
                fn multiply(x: f64, y: f64) -> f64 {
                    x * y
                }
                ```
                """
        ),

    ]

}

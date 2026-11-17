//
//  SampleDocuments.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import Foundation

extension MarkdownDocument {
    static let sample = sampleData[0]

    static let codeSample = sampleData[8]

    static let sampleData = [
        MarkdownDocument(
            content: """
                # Quick note

                *Let's be quick*, I am in a rush, so:

                - Don't worry
                - Be happy
                """,
            addresses: ["bmcferr@music.wrld"],
            subject: "Quick",
        ),

        MarkdownDocument(
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

        MarkdownDocument(
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

        MarkdownDocument(
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
        MarkdownDocument(
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
        MarkdownDocument(
            content: """
                # Syniad Gwych

                Dw i wedi cael syniad gwych.
                Dylech chi brynu clwb pel droed yng ngogledd Cymru. 
                """,
            addresses: ["r.mac@sunny.phl", "r.reyn@ddpl.com"],
            subject: "Syniad",
            timestamp: .now.addingTimeInterval(-86400 * 5)
        ),
        MarkdownDocument(
            content: """
                # Ideas for new apps

                - Markdown editor
                - Bus Tracker
                - Historic price/mass tracker

                Don't share these
                """,
            timestamp: .now.addingTimeInterval(-86400 * 6)
        ),
        MarkdownDocument(
            content: """
                # No try

                I can't decide whether to make this a reference to a certain short sci-fi figure,
                or to make it about rugby!
                """,
            addresses: ["green@temple.crscnt", "cym@rugby.wrld"],
            subject: "No try",
            timestamp: .now.addingTimeInterval(-86400 * 7)
        ),
        MarkdownDocument(
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

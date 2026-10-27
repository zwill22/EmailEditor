//
//  Address.swift
//  MdEditor
//
//  Created by Zack Williams on 27-10-2026.
//

import Foundation
import SwiftData

@Model
class Address: Identifiable {
    var id: UUID
    var address: String

    init(id: UUID = UUID(), address: String) {
        self.id = id
        self.address = address
    }
}

extension Address {
    static let sampleData: [Address] = [
        .init(address: "mike@gta.sa"),
        .init(address: "trev@gta.sa"),
        .init(address: "frnk@gta.sa"),
        .init(address: "spck@ent.sf"),
        .init(address: "mccy@ent.sf"),
        .init(address: "uhr@ent.sf"),
        .init(address: "sctty@ent.sf"),
        .init(address: "rnd@xclsr.sf"),
        .init(address: "odo@dsn.bj"),
        .init(address: "ng@dfnt.sf"),
        .init(address: "mgrth-fan@mddl.ea"),
        .init(address: "srn@eye.mrdr"),
        .init(address: "clbrmbr@hlln.ea"),
        .init(address: "r.mac@sunny.phl"),
        .init(address: "r.reyn@ddpl.com"),
        .init(address: "green@temple.crscnt"),
        .init(address: "cym@rugby.wrld"),
    ]
}

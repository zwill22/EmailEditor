//
//  EmailDetails.swift
//  MdEditor
//
//  Created by Zack Williams on 12-11-2026.
//

import SwiftMail

struct EmailDetails {
    var text: String
    var email: String
    var addresses: [String]
    var subject: String

    func toEmail(credentials: EmailCredentials) -> Email {
        return Email(
            senderName: credentials.emailAddress.address,
            senderAddress: credentials.emailAddress.address,
            recipientNames: addresses,
            recipientAddresses: addresses,
            subject: subject,
            textBody: text,
            htmlBody: email
        )
    }
}

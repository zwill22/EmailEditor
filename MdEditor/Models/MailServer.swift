//
//  MailServer.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftMail

@MainActor
struct MailServer {
    private var server: SMTPServer

    func login(username: String, password: String) async throws {
        try await server.login(username: username, password: password)
    }

    func send(
        text: String,
        email: String,
        fromAddress: String,
        addresses: [String],
        subject: String
    ) async throws {
        let email = Email(
            senderName: fromAddress,
            senderAddress: fromAddress,
            recipientNames: addresses,
            recipientAddresses: addresses,
            subject: subject,
            textBody: text,
            htmlBody: email
        )
        
        try await server.sendEmail(email)
    }

    func disconnect() async throws {
        try await server.disconnect()
    }

    init(host: String, port: Int) async throws {
        self.server = SMTPServer(host: host, port: port)

        try await server.connect()
    }
}

//
//  MailServer.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftMail

@MainActor
protocol MailServer {
    func validate(
        credentials: EmailCredentials
    ) async throws

    func send(
        credentials: EmailCredentials,
        emailDetails: EmailDetails
    ) async throws
}

@MainActor
class EMailServer: MailServer {
    private func connect(
        credentials: EmailCredentials
    ) async throws -> SMTPServer {
        let server = SMTPServer(host: credentials.host, port: credentials.port)

        do {
            try await server.connect()
        } catch {
            throw ServerError.unableToConnect(error: error)
        }

        do {
            try await server.login(
                username: credentials.emailAddress.address,
                password: credentials.password
            )
        } catch {
            throw ServerError.loginError(error: error)
        }

        return server

    }

    func validate(credentials: EmailCredentials) async throws {
        let server = try await connect(credentials: credentials)

        try await server.disconnect()
    }

    func send(credentials: EmailCredentials, emailDetails: EmailDetails) async throws
    {
        let server = try await connect(credentials: credentials)

        let email = emailDetails.toEmail(credentials: credentials)

        try await server.sendEmail(email)
    }

}

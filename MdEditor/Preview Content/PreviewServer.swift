//
//  PreviewServer.swift
//  MdEditor
//
//  Created by Zack Williams on 12-11-2026.
//

func wait() async throws {
    try await Task.sleep(
        nanoseconds: UInt64.random(in: 100_000_000...500_000_000)
    )
}

class PreviewServer: MailServer {
    private var validServer: Bool
    private var validUser: Bool

    private func connect() async throws {
        try await wait()

        if !validServer {
            throw EditorError.serverConnectionError(server: "Server", port: 123)
        }

        try await wait()

        if !validUser {
            throw EditorError.serverLoginError(name: "Server")
        }

    }

    func validate(credentials: EmailCredentials) async throws {
        try await connect()
    }

    func send(credentials: EmailCredentials, emailDetails: EmailDetails)
        async throws
    {
        try await connect()
    }

    init(validServer: Bool, validUser: Bool) {
        self.validServer = validServer
        self.validUser = validUser
    }
}

extension PreviewServer {
    static var valid: MailServer {
        PreviewServer(validServer: true, validUser: true)
    }

    static var invalidUser: MailServer {
        PreviewServer(validServer: true, validUser: false)
    }

    static var invalidServer: MailServer {
        PreviewServer(validServer: false, validUser: false)
    }
}

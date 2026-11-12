//
//  SampleCredentials.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

extension EmailCredentials {
    static let sample = sampleData[0]

    static let sampleData = [
        EmailCredentials(
            name: "AOL",
            host: "smtp.aol.com",
            port: 587,
            username: "myAOLUsername",
            password: "Password",
            address: "me@aol.com",
        ),
        EmailCredentials(
            name: "GMail",
            host: "smtp.gmail.com",
            port: 465,
            username: "myGoogleAccount",
            password: "GoogleAppPassword",
            address: "me@gmail.com",
        ),
        EmailCredentials(
            name: "iCloud",
            host: "smtp.mail.me.com",
            port: 587,
            username: "myAppleUsername",
            password: "icloudAppPassword",
            address: "me@icloud.com",

        ),
        EmailCredentials(
            name: "Office365",
            host: "smtp.office365.com",
            port: 587,
            username: "microsoftOfficeAccount",
            password: "officePassword",
            address: "me@office365.com",
        ),
    ]
}

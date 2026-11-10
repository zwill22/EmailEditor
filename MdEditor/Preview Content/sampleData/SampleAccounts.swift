//
//  SampleAccounts.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

extension EmailAccount {
    static let sample = sampleData[0]

    static let sampleData = [
        EmailAccount(
            name: "AOL",
            host: "smtp.aol.com",
            port: 587,
            username: "myAOLUsername",
            emailAddress: "me@aol.com",
            password: "Password",
        ),
        EmailAccount(
            name: "GMail",
            host: "smtp.gmail.com",
            port: 465,
            username: "myGoogleAccount",
            emailAddress: "me@gmail.com",
            password: "GoogleAppPassword",
        ),
        EmailAccount(
            name: "iCloud",
            host: "smtp.mail.me.com",
            port: 587,
            username: "myAppleUsername",
            emailAddress: "me@icloud.com",
            password: "icloudAppPassword",

        ),
        EmailAccount(
            name: "Office365",
            host: "smtp.office365.com",
            port: 587,
            username: "microsoftOfficeAccount",
            emailAddress: "me@office365.com",
            password: "officePassword",
        ),
    ]
}

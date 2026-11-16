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
            emailAddress: "myAOLUsername@aol.com",
            password: "Password",
        ),
        EmailCredentials(
            name: "GMail",
            host: "smtp.gmail.com",
            port: 465,
            emailAddress: "myGoogleName@gmail.com",
            password: "GoogleAppPassword",
        ),
        EmailCredentials(
            name: "iCloud",
            host: "smtp.mail.me.com",
            port: 587,
            emailAddress: "myAppleUsername@icloud.com",
            password: "icloudAppPassword",

        ),
        EmailCredentials(
            name: "Office365",
            host: "smtp.office365.com",
            port: 587,
            emailAddress: "microsoftOfficeAccount@office365.com",
            password: "officePassword",
        ),
    ]
}

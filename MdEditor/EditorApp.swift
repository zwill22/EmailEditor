//
//  EditorApp.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

@main
struct EditorApp: App {
    let dataContainer = DataContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
                .modelContainer(dataContainer.modelContainer)
        }
        .windowResizability(.contentSize)

        WindowGroup("Preview Window", id: "htmlPreview", for: String.self) {
            $htmlString in
            HTMLView(html: htmlString ?? "")
        }

        Settings {
            SettingsView()
                .environment(dataContainer)
                .modelContainer(dataContainer.modelContainer)

        }
        .windowIdealSize(.fitToContent)
    }
}

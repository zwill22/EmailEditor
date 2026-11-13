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
    @AppStorage("selectedColourScheme") private var selectedColourScheme:
        AppColourScheme = .system

    let dataContainer = DataContainer()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(dataContainer)
                .modelContainer(dataContainer.modelContainer)
                .preferredColorScheme(
                    selectedColourScheme.resolve()
                )
        }
        .windowResizability(.contentSize)

        WindowGroup("Preview Window", id: "htmlPreview", for: String.self) {
            $htmlString in
            HTMLView(html: htmlString ?? "")
                .preferredColorScheme(selectedColourScheme.resolve())
        }

        Settings {
            SettingsView()
                .environment(dataContainer)
                .modelContainer(dataContainer.modelContainer)
                .preferredColorScheme(selectedColourScheme.resolve())

        }
        .windowResizability(.contentSize)
    }
}

//
//  EmailEditorApp.swift
//  EmailEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

@main
struct EmailEditorApp: App {
    let dataContainer = DataContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
        .windowResizability(.contentSize)
    }
}

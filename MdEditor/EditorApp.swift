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
        .modelContainer(dataContainer.modelContainer)
        .windowResizability(.contentSize)
    }
}

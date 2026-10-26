//
//  DataContainer.swift
//  EmailEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftData
import SwiftUI

@Observable
@MainActor
class DataContainer {
    let modelContainer: ModelContainer

    var context: ModelContext {
        modelContainer.mainContext
    }

    init(includeSample: Bool = false) {
        let schema = Schema([
            Message.self
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: includeSample
        )

        do {
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )

            if includeSample {
                loadSamples()
            }

            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    private func loadSamples() {
        for message in Message.sampleData {
            context.insert(message)
        }
    }
}

private let sampleContainer = DataContainer(includeSample: true)

extension View {
    func sampleDataContainer() -> some View {
        self.environment(sampleContainer).modelContainer(
            sampleContainer.modelContainer
        )
    }
}

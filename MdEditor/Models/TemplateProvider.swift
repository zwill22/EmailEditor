//
//  TemplateProvider.swift
//  MdEditor
//
//  Created by Zack Williams on 29-10-2026.
//

import Foundation

@MainActor
@Observable
class TemplateProvider {
    var templates: [Template] = []

    private var initialised: Bool = false

    func fetchTemplates() throws {
        if initialised {
            print("Initialised already")
            return
        }

        let urls = Bundle.main.paths(
            forResourcesOfType: "hbs",
            inDirectory: nil
        )

        let emails = urls.compactMap { try? Template(path: $0) }

        self.templates = emails
        self.initialised = true
    }

    func get(name: String) -> Template? {
        if let index = templates.firstIndex(where: { $0.name == name }) {
            return templates[index]
        }

        return nil
    }
}

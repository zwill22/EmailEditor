//
//  DataLoader.swift
//  MdEditor
//
//  Created by Zack Williams on 09-11-2026.
//

import Foundation

struct DataLoader {
  static func loadSampleEmail() -> String {
    for bundle in Bundle.allBundles {
      if let url = bundle.url(forResource: "SampleEmail", withExtension: "html") {
        do {
            let out = try String(contentsOf: url, encoding: .utf8)
          return out
        } catch {
          fatalError("Failed to load SampleEmail.html: \(error)")
        }
      }
    }
      
    fatalError("SampleEmail.html not found in any bundle.")
  }
}

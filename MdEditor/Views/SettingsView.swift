//
//  SettingsView.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            Tab("General", systemImage: "gear") {
                GeneralSettingsView()
            }
            
            Tab("Accounts", systemImage: "at.circle") {
                AccountSettingsView()
            }
        }
        .frame(width: 800, height: 400)
        .scenePadding(.vertical)
    }
}

#Preview {
    SettingsView()
        .sampleDataContainer()
}

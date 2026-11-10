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
            Tab("Accounts", systemImage: "at.circle") {
                AccountSettingsView()
            }
        }
        .frame(minWidth: 400, minHeight: 200)
        .scenePadding()
    }
}

#Preview {
    SettingsView()
        .sampleDataContainer()
}

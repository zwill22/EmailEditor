//
//  DeleteButton.swift
//  MdEditor
//
//  Created by Zack Williams on 17-11-2026.
//

import SwiftData
import SwiftUI

struct DeleteButton: View {
    var item: String

    var delete: () -> Void

    @State private var showConfirmation = false

    private var confirmDeleteButton: some View {
        Button("Delete \(item)", role: .destructive) {
            delete()
        }
    }

    var body: some View {
        Button("Delete", systemImage: "trash") {
            showConfirmation = true
        }
        .confirmationDialog(
            "Permenently delete \(item)",
            isPresented: $showConfirmation
        ) {
            confirmDeleteButton
        } message: {
            Text("The \(item) will be permenently deleted")
        }
    }
}

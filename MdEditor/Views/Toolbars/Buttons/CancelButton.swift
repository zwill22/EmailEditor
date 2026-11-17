//
//  CancelButton.swift
//  MdEditor
//
//  Created by Zack Williams on 17-11-2026.
//

import SwiftUI

struct CancelButton: View {
    var dismiss: () -> Void
    var unchanged: () -> Bool

    @State private var showConfirmation = false

    var discardButton: some View {
        Button("Discard Changes", role: .destructive) {
            dismiss()
        }
    }

    var body: some View {
        Button("Cancel", systemImage: "xmark") {
            if unchanged() {
                dismiss()
            } else {
                showConfirmation = true
            }
        }
        .confirmationDialog(
            "Discard changes",
            isPresented: $showConfirmation
        ) {
            discardButton
        }
    }
}

private func dismiss() {}
private func unchanged() -> Bool {
    return true
}

#Preview {
    CancelButton(dismiss: dismiss, unchanged: unchanged)
}

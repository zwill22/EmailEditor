//
//  SaveButton.swift
//  MdEditor
//
//  Created by Zack Williams on 17-11-2026.
//

import SwiftData
import SwiftUI

struct SaveButton: View {
    var dismiss: () -> Void
    var unchanged: () -> Bool
    var update: () throws -> Void
    var disableSaveButton: (() -> Bool)?

    @Binding var errorHandler: ErrorHandler

    @State private var showConfirmation = false

    var saveAndExitButton: some View {
        Button("Save", role: .confirm) {
            do {
                try update()

                dismiss()
            } catch {
                onError(error)
            }
        }
    }

    var body: some View {
        Button("Save", systemImage: "checkmark") {
            if unchanged() {
                dismiss()
            } else {
                showConfirmation = true
            }
        }
        .confirmationDialog(
            "Save changes",
            isPresented: $showConfirmation
        ) {
            saveAndExitButton
        }
        .disabled(disableSaveButton != nil ? disableSaveButton!() : unchanged())
    }
}

private func onError(_: any Error) {}
private func dismiss() {}
private func boolFn() -> Bool {
    return false
}

#Preview {
    SaveButton(
        dismiss: dismiss,
        unchanged: boolFn,
        update: dismiss,
        disableSaveButton: boolFn,
        errorHandler: .constant(ErrorHandler())
    )
}

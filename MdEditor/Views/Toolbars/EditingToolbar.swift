//
//  EditingToolbar.swift
//  MdEditor
//
//  Created by Zack Williams on 14-11-2026.
//

import SwiftUI

struct EditingToolbar: ToolbarContent {
    var dismiss: () -> Void
    var unchanged: () -> Bool
    var update: () throws -> Void
    var disableSaveButton: (() -> Bool)?

    @State private var content: String = ""
    @State private var showSaveConfirmation = false
    @State private var showCancelConfirmation = false

    var discardButton: some View {
        Button("Discard Changes", role: .destructive) {
            print("Discard button pressed, dismissing...")
            dismiss()
        }
    }

    var cancelButton: some View {
        Button {
            print("Cancel button pressed...")
            if unchanged() {
                print("Data is unchanged, dismissing...")
                dismiss()
            } else {
                print("Data changed, require confirmation...")
                showCancelConfirmation = true
            }
        } label: {
            Label("Cancel", systemImage: "xmark")
        }
        .confirmationDialog(
            "Discard changes",
            isPresented: $showCancelConfirmation
        ) {
            discardButton
        }
    }

    var saveAndExitButton: some View {
        Button("Save", role: .confirm) {
            do {
                print("Saving state...")
                try update()

                print("State saved, dismissing...")
                dismiss()
            } catch {
                print("Error saving state")
                //
            }
        }
    }

    private func checkDisabled() -> Bool {
        print("Checking if save button is disabled...")

        return unchanged()
    }

    var saveButton: some View {
        Button {
            print("Save button pressed...")
            if unchanged() {
                print("Data is unchanged, dismissing...")
                dismiss()
            } else {
                print("Data has changed, checking for confirmation...")
                showSaveConfirmation = true
            }
        } label: {
            Label("Save", systemImage: "checkmark")
        }
        .confirmationDialog(
            "Save changes",
            isPresented: $showSaveConfirmation
        ) {
            saveAndExitButton
        }
        .disabled(disableSaveButton != nil ? disableSaveButton!() : unchanged())
    }

    var body: some ToolbarContent {
        ToolbarItem(placement: .destructiveAction) {
            cancelButton
        }

        ToolbarItem(placement: .confirmationAction) {
            saveButton
        }
    }
}

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

    @Binding var errorHandler: ErrorHandler
    
    @State private var content: String = ""

    var body: some ToolbarContent {
        ToolbarItem(placement: .destructiveAction) {
            CancelButton(dismiss: dismiss, unchanged: unchanged)
        }

        ToolbarItem(placement: .confirmationAction) {
            SaveButton(
                dismiss: dismiss,
                unchanged: unchanged,
                update: update,
                errorHandler: $errorHandler
            )
        }
    }
}

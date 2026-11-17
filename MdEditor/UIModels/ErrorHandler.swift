//
//  ErrorHandler.swift
//  MdEditor
//
//  Created by Zack Williams on 17-11-2026.
//

import Foundation

@Observable
class ErrorHandler {
    var error: EditorError?
    var hasError = false

    func handle(_ err: any Error) {
        self.error = err as? EditorError ?? .unexpectedError(error: err)
        self.hasError = true
    }
}

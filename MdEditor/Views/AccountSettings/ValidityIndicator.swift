//
//  ValidityIndicator.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftUI

struct ValidityIndicator: View {
    @Binding var emailAccount: EmailAccount

    @State private var loading = true
    @State private var valid = false

    var size: CGFloat = 40.0
    var fontSize: Font = .largeTitle

    private var cornerRadius: CGFloat {
        size / 4.0
    }
    
    private var loadView: some View {
        RoundedRectangle(
            cornerRadius: cornerRadius,
            style: .continuous
        )
        .fill(.secondary)
        .frame(width: size, height: size)
        .overlay {
            ProgressView().font(fontSize)
        }
    }

    private var greenTick: some View {
        RoundedRectangle(
            cornerRadius: cornerRadius,
            style: .continuous
        )
        .fill(.green)
        .frame(width: size, height: size)
        .overlay {
            Image(systemName: "checkmark.circle").font(fontSize)
        }
    }

    private var redCross: some View {
        RoundedRectangle(
            cornerRadius: cornerRadius,
            style: .continuous
        )
        .fill(.red)
        .frame(width: size, height: size)
        .overlay {
            Image(systemName: "x.circle").font(fontSize)
        }
    }
    
    private func update() {
        Task {
            self.loading = true
            
            self.valid = await emailAccount.isValid()
            
            self.loading = false
        }
    }

    var body: some View {
        Group {
            if loading {
                loadView
            } else if valid {
                greenTick
            } else {
                redCross
            }
        }.onChange(of: emailAccount.credentials.values) {
            update()
        }.onAppear {
            update()
        }
    }
}

#Preview {
    ForEach(EmailAccount.sampleData) { sample in
        ValidityIndicator(emailAccount: .constant(sample))
    }
}

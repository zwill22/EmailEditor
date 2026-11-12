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
        self.loading = true
        
        Task {
            self.valid = await emailAccount.isValid()
        }
        
        self.loading = false
    }

    var body: some View {
        Group {
            if loading {
                ProgressView()
                    .frame(width: size, height: size)
            } else if valid {
                greenTick
            } else {
                redCross
            }
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

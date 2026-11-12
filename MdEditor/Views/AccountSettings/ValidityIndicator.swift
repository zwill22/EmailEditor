//
//  ValidityIndicator.swift
//  MdEditor
//
//  Created by Zack Williams on 10-11-2026.
//

import SwiftUI

struct ValidityIndicator: View {
    @Binding var valid: Bool
    @Binding var loading: Bool

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

    var body: some View {
        if loading {
            ProgressView()
                .frame(width: size, height: size)
        } else if valid {
            greenTick
        } else {
            redCross
        }
    }
}

#Preview {
    HStack {
        ValidityIndicator(valid: .constant(false), loading: .constant(true))
        ValidityIndicator(valid: .constant(false), loading: .constant(false))

        ValidityIndicator(valid: .constant(true), loading: .constant(true))
        ValidityIndicator(valid: .constant(true), loading: .constant(false))
    }
}

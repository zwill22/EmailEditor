//
//  Icon.swift
//  MdEditor
//
//  Created by Zack Williams on 21-10-2026.
//

import SwiftUI

struct Icon: View {
    var height: CGFloat = 60
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(
                .secondary
            )
            .frame(width: 60, height: height)
            .overlay {
                Image(systemName: "envelope.open").font(.largeTitle)
                    .foregroundStyle(
                        .primary
                    )
            }
    }
}

#Preview {
    Icon()
}

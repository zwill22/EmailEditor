//
//  HTMLView.swift
//  MdEditor
//
//  Created by Zack Williams on 09-11-2026.
//

import SwiftUI
import WebKit

struct HTMLView: View {
    @State private var page = WebPage()

    var html: String

    var body: some View {
        NavigationStack {
            WebView(page)
                .onAppear {
                    page.load(html: html)
                }
                .overlay(content: {
                    if (page.isLoading) {
                        ProgressView()
                    }
                })
                .navigationTitle(page.title)
        }
    }
}

#Preview {
    HTMLView(html: DataLoader.loadSampleEmail())
}

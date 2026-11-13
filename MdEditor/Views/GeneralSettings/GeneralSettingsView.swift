//
//  GeneralSettingsView.swift
//  MdEditor
//
//  Created by Zack Williams on 13-11-2026.
//

import SwiftUI

let settingsText = """
    # Preview

    This shows the current settings. Here is a quote:

    > In the beginning, the Universe was created.
    > This has made a lot of people very angry and been widely regarded as a bad move.

    And some code:

    ```python

    class Example:

        def __init__(self, value):
            self.value = value

    k = Example(42)

    print(f"k = {k}")
    ```
    """

struct GeneralSettingsView: View {
    @AppStorage("blockQuoteTheme")
    private var blockQuoteTheme: BlockQuoteTheme = .github

    @AppStorage("codeTheme")
    private var codeTheme: CodeTheme = .xcode

    @AppStorage("selectedColourScheme")
    private var selectedColourScheme: AppColourScheme = .system

    var body: some View {
        HSplitView {
            Form {
                Section(header: Text("App settings").font(.title2)) {
                    Picker("Colour Scheme", selection: $selectedColourScheme) {
                        ForEach(AppColourScheme.allCases) { scheme in
                            Text(scheme.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Spacer()
                
                Section(header: Text("Markdown theme").font(.title2)) {
                    Picker("Code blocks", selection: $codeTheme) {
                        ForEach(CodeTheme.allCases) { theme in
                            Text(theme.rawValue.capitalized)
                        }
                    }

                    Picker("Block Quotes", selection: $blockQuoteTheme) {
                        ForEach(BlockQuoteTheme.allCases) { theme in
                            Text(theme.rawValue.capitalized)
                        }
                    }.pickerStyle(.segmented)

                    Spacer()
                }

            }.padding()

            DocumentContentView(content: settingsText)
        }
    }
}

#Preview {
    GeneralSettingsView()
}

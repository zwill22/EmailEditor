//
//  MarkdownConverter.swift
//  MdEditor
//
//  Created by Zack Williams on 03-11-2026.
//

import Foundation
import Ink

struct HtmlGenerator {
    private var parser = MarkdownParser()

    let styles = [
        "code": [
            "color": "#212529",
            "font-size": "87.5%",
            "display": "inline",
            "background": "#f8f8f8",
            "font-family": "SFMono-Regular,Menlo,Monaco,Consolas,monospace",
            "word-wrap": "break-word",
        ],
        "pre": [
            "color": "#212529",
            "font-size": "87.5%",
            "display": "block",
            "background": "#f8f8f8",
            "font-family": "SFMono-Regular,Menlo,Monaco,Consolas,monospace",
            "padding-top": "10px",
            "padding-right": "10px",
            "padding-left": "10px",
            "padding-bottom": "1px",
            "margin-bottom": "20px",
            "word-wrap": "break-word",
        ],

        "blockquote": [
            "background": "#f9f9f9",
            "border-left": "10px solid #ccc",
            "margin": "1.5em 10px",
            "padding": "1em 10px",
        ],
    ]

    let modifiers: [String: Modifier.Target] = [
        "code": .inlineCode,
        "pre": .codeBlocks,
        "blockquote": .blockquotes,
    ]

    func get_style(key: String) -> String {
        let style = styles[key]!

        var out = ""
        for (k, v) in style {
            out += "\(k):\(v);"
        }

        return out
    }

    mutating func toHtml<StringType>(markdown: StringType) -> String
    where StringType: StringProtocol {

        for (k, v) in modifiers {

            let style = get_style(key: k)

            let modifier = Modifier(target: v) { html, markdown in
                return html.replacingOccurrences(
                    of: "<\(k)>",
                    with: "<\(k) style=\"\(style)\">"
                )
            }

            self.parser.addModifier(modifier)

        }

        return parser.html(from: String(markdown))
    }
}

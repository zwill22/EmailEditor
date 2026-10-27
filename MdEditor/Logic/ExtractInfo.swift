//
//  Regex.swift
//  MdEditor
//
//  Created by Zack Williams on 27-10-2026.
//

import Foundation

class Regex {
    var pattern: String

    var regex: NSRegularExpression

    func range(inputString: String) -> NSRange {
        NSRange(location: 0, length: inputString.utf16.count)
    }

    func extractFirst(inputString: String) -> [String]? {
        let stringRange = range(inputString: inputString)
        let matches = regex.matches(in: inputString, range: stringRange)

        for match in matches {
            var groups: [String] = []
            for rangeIndex in 1..<match.numberOfRanges {
                let nsRange = match.range(at: rangeIndex)

                guard !NSEqualRanges(nsRange, NSMakeRange(NSNotFound, 0)) else {
                    continue
                }

                let string = (inputString as NSString).substring(with: nsRange)

                groups.append(string)
            }

            if !groups.isEmpty {
                return groups
            }
        }

        return nil
    }

    func replace(inputString: String, substitutionString: String) -> String {
        let stringRange = range(inputString: inputString)

        return regex.stringByReplacingMatches(
            in: inputString,
            range: stringRange,
            withTemplate: substitutionString
        )
    }

    init(pattern: String) {
        self.pattern = pattern
        self.regex = try! NSRegularExpression(
            pattern: pattern,
            options: .anchorsMatchLines
        )
    }
}

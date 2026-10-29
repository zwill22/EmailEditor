//
//  Regex.swift
//  MdEditor
//
//  Created by Zack Williams on 27-10-2026.
//

import Foundation

extension NSTextCheckingResult {
    func getGroups(inputString: String) -> [String] {
        var groups: [String] = []
        for rangeIndex in 1..<self.numberOfRanges {
            let nsRange = self.range(at: rangeIndex)

            guard !NSEqualRanges(nsRange, NSMakeRange(NSNotFound, 0)) else {
                continue
            }

            let string = (inputString as NSString).substring(with: nsRange)

            groups.append(string)
        }

        return groups
    }
}

class Regex {
    var pattern: String

    private var regex: NSRegularExpression

    private func range(inputString: String) -> NSRange {
        NSRange(location: 0, length: inputString.utf16.count)
    }

    private func getMatches(inputString: String) -> [NSTextCheckingResult] {
        let stringRange = range(inputString: inputString)
        return regex.matches(in: inputString, range: stringRange)
    }

    func extractFirst(inputString: String) -> [String]? {
        let matches = getMatches(inputString: inputString)

        for match in matches {
            let groups = match.getGroups(inputString: inputString)

            if !groups.isEmpty {
                return groups
            }
        }

        return nil
    }

    func extractAll(inputString: String) -> Set<String> {
        let matches = getMatches(inputString: inputString)

        var results: Set<String> = .init()
        for match in matches {
            let groups = match.getGroups(inputString: inputString)

            for group in groups {
                results.insert(group)
            }
        }

        return results
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

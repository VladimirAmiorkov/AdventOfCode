//
//  File.swift
//  
//
//  Created by Vladimir Amiorkov on 3.12.23.
//

import Foundation

struct RegexMatcher {
    
    static func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    static func captureGroups(for regex: String, in text: String) -> [[Match]] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let textRange = NSRange(
                text.startIndex..<text.endIndex,
                in: text
            )
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                var values: [Match] = []
                
                for rangeIndex in 0..<$0.numberOfRanges {
                    let matchRange = $0.range(at: rangeIndex)
                    
                    // Ignore matching the entire username string
                    if matchRange == textRange { continue }
                    
                    // Extract the substring matching the capture group
                    if let substringRange = Range(matchRange, in: text) {
                        let capture = String(text[substringRange])
                        values.append(Match(range: matchRange, value: capture))
                    }
                }
                
                return values
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    struct Match {
        let range: NSRange
        let value: String
    }
}

//
//  NumbersParser.swift
//
//
//  Created by Vladimir Amiorkov on 2.12.23.
//

import Foundation

protocol NumbersParserProtocol {
    static func replaceStringsWithNumbers(input: [String]) -> [String]
    static func removeChars(input: [String]) -> [String]
}

struct NumbersParser {
    
    private static func replaceStringsWithNumbersInLine(line: String) -> String {
        var partialLine = ""
        consolePrint("Parsing line '\(line)'")
        
        var leadingResult = ""
        // MARK: Leading lookup
        for character in line {
            partialLine.append(character)
            
            let stringChar = String(character)
            if Digits.allCases.contains(where: { $0.stringValue == stringChar }) {
                consolePrint("Parsed '\(partialLine)' to '\(stringChar))'")
                leadingResult += stringChar
                break
            } else {
                for digit in Digits.allCases {
                    let parsed = partialLine.replacingOccurrences(of: digit.rawValue, with: digit.stringValue)
                    
                    if parsed != partialLine {
                        consolePrint("Parsed '\(partialLine)' to '\(parsed))'")
                              
                        leadingResult += parsed
                        break
                    }
                }
            }
        }
        
        partialLine = ""
        
        var trailingResult = ""
        // MARK: Trailing lookup
        for character in line.reversed() {
            guard trailingResult.isEmpty else { break }
            
            partialLine.append(character)
            
            let stringChar = String(character)
            if Digits.allCases.contains(where: { $0.stringValue == stringChar }) {
                consolePrint("Parsed '\(partialLine)' to '\(stringChar))'")
                trailingResult += stringChar
                break
            } else {
                for digit in Digits.allCases {
                    let normalised = String(partialLine.reversed())
                    let parsed = normalised.replacingOccurrences(of: digit.rawValue, with: digit.stringValue)
                    
                    if parsed != normalised {
                        consolePrint("Parsed '\(normalised)' to '\(parsed))'")
                              
                        trailingResult += parsed
                        break
                    }
                }
            }
        }
        
        leadingResult += trailingResult
        
        consolePrint("Parsed line '\(line)' to '\(leadingResult)'")
        
        return leadingResult
    }
}

// MARK: Enums
extension NumbersParser {
    
    enum Digits: String, CaseIterable {
        case one, two, three, four, five, six, seven, eight, nine
        
        var stringValue: String {
            switch self {
            case .one:
                "1"
            case .two:
                "2"
            case .three:
                "3"
            case .four:
                "4"
            case .five:
                "5"
            case .six:
                "6"
            case .seven:
                "7"
            case .eight:
                "8"
            case .nine:
                "9"
            }
        }
    }
}

// MARK: NumbersParserProtocol
extension NumbersParser: NumbersParserProtocol {
    
    /// Replaces decimal english words (one, two ...) with the actual decimal (1, 2 ...)
    ///
    /// With the exception of "zero"
    static func replaceStringsWithNumbers(input: [String]) -> [String] {
        var parsed: [String] = []
        
        input.forEach { line in
            let parsedLine = replaceStringsWithNumbersInLine(line: line)
            
            parsed.append(parsedLine)
        }
        
        return parsed
    }
    
    /// Removes all non decimal characters.
    static func removeChars(input: [String]) -> [String] {
        var parsed: [String] = []
        
        input.forEach { line in
            let parsedLine = line.filter("0123456789".contains)
            
            guard let first = parsedLine.first, let last = parsedLine.last else { return }
            
            let strNum = "\(first)\(last)"
            
            consolePrint("Answer from line '\(line)' is '\(strNum)'")
            parsed.append(strNum)
        }
        
        return parsed
    }
}

// MARK: ConsolePrintable
extension NumbersParser: ConsolePrintable {
    
    var enableConsolePrint: Bool {
        Self.enableConsolePrint
    }
    
    static var enableConsolePrint: Bool {
        false
    }
}

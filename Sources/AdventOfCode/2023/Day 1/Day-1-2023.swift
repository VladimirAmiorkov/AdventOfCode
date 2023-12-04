//
//  Day-1-2023.swift
//
//
//  Created by Vladimir Amiorkov on 2.12.23.
//

import Foundation

/// Solution to https://adventofcode.com/2023/day/1
public struct Day_1_2023 { }

// MARK: AdventTaskExecutable
extension Day_1_2023: AdventTaskExecutable {
    
    public func execute(input: Any) -> Any? {
        guard let input = InputParser.parse(input: input) else { return nil }
        
        var parsed = NumbersParser.replaceStringsWithNumbers(input: input)
        parsed = NumbersParser.removeChars(input: parsed)
        
        assert(input.count == parsed.count)

        let answer = parsed.reduce(into: 0) { partialResult, stringNumber in
            guard let number = Int(stringNumber) else {
                return
            }
            partialResult += number
        }
        
        consolePrint("Day 1-2023 - input: \n\(input)")
        consolePrint("Day 1-2023 - answer: '\(answer)'")
        
        return answer
    }
    
    func executePartTwo(input: Any) -> Any? {
        /* NOOP */
        
        return nil
    }
}

// MARK: ConsolePrintable
extension Day_1_2023: ConsolePrintable {
    
    var enableConsolePrint: Bool {
        Self.enableConsolePrint
    }
    
    static var enableConsolePrint: Bool {
        true
    }
}

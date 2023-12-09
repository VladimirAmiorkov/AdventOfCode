//
//  Day-5-2023.swift
//
//
//  Created by Vladimir Amiorkov on 9.12.23.
//

import Foundation

struct Day_5_2023 {
    
}

// MARK: AdventTaskExecutable
extension Day_5_2023: AdventTaskExecutable {
    
    public func execute(input: Any) -> Any? {
        guard let inputParsed = InputParser.parse(input: input) else { return nil }
        
//        let cards = Parser.parse(lines: inputParsed)
        let answer: Int = 0
        
        consolePrint("Day 4-2023 part 1 - input: \n\(input)")
        consolePrint("Day 4-2023 part 1 - answer: '\(answer)'")
        
        return answer
    }
    
    func executePartTwo(input: Any) -> Any? {
        guard let inputParsed = InputParser.parse(input: input) else { return nil }
        
//        let cards = Parser.parse(lines: inputParsed)
//        let answer: Int = cards.resultPart2
        
        let answer: Int = 0
        
        consolePrint("Day 4-2023 part 2 - input: \n\(input)")
        consolePrint("Day 4-2023 part 2 - answer: '\(answer)'")
        
        return answer
    }
}

// MARK: Parsing
extension Day_5_2023 {
    
    struct Parser {
        
        private enum Const {
            static let cardIdRegEx = "Card[ ]{1,}(\\d+)"
            static let numberRegEx = "(\\d+)"
        }
        
    }
}

// MARK: ConsolePrintable
extension Day_5_2023: ConsolePrintable {
    
    var enableConsolePrint: Bool {
        Self.enableConsolePrint
    }
    
    static var enableConsolePrint: Bool {
        true
    }
}

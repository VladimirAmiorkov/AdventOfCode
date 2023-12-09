//
//  Day-4-2023.swift
//
//
//  Created by Vladimir Amiorkov on 6.12.23.
//

import Foundation

struct Day_4_2023 {
    
}


// MARK: AdventTaskExecutable
extension Day_4_2023: AdventTaskExecutable {
    
    public func execute(input: Any) -> Any? {
        guard let inputParsed = InputParser.parse(input: input) else { return nil }
        
        let cards = Parser.parse(lines: inputParsed)
        let answer: Decimal = cards.result
        
        consolePrint("Day 4-2023 part 1 - input: \n\(input)")
        consolePrint("Day 4-2023 part 1 - answer: '\(answer)'")
        
        return answer
    }
    
    func executePartTwo(input: Any) -> Any? {
        guard let inputParsed = InputParser.parse(input: input) else { return nil }
        
        let cards = Parser.parse(lines: inputParsed)
        let answer: Int = cards.resultPart2
        
        consolePrint("Day 4-2023 part 2 - input: \n\(input)")
        consolePrint("Day 4-2023 part 2 - answer: '\(answer)'")
        
        return answer
    }
}

// MARK: Parsing
extension Day_4_2023 {
    
    struct Card {
        let id: Int
        let values: [Int]
        let winningValues: [Int]
        
        var value: Decimal {
            let matches = Array(Set(values).intersection(Set(winningValues))).count
            
            return matches == 1 ? 1 : Math.geometricProgression(
                term: Array(Set(values).intersection(Set(winningValues))).count,
                firstTerm: 1, commonRation: 2
            )
        }
        
        var matches: [Int] {
            Array(Set(values).intersection(Set(winningValues)))
        }
        
        var matchesCount: Int {
            matches.count
        }
    }
    
    struct Parser {
        
        private enum Const {
            static let cardIdRegEx = "Card[ ]{1,}(\\d+)"
            static let numberRegEx = "(\\d+)"
        }
        
        static func parse(lines: [String]) -> [Card] {
            var cards: [Card] = []
            
            lines.forEach { line in
                guard let card = parse(line: line) else { return }
                cards.append(card)
            }
            
            return cards
        }
        
        static func parse(line: String) -> Card? {
            let cardIDMatch = RegexMatcher.captureGroups(for: Const.cardIdRegEx, in: line)
            
            guard let match = cardIDMatch.first, let id = match.last?.value, let idInt = Int(id), let idfullMatch = match.first?.value else { 
                assertionFailure("Not expected")
                return nil
            }
            
            let leftOver = line.replacingOccurrences(of: idfullMatch, with: "").replacingOccurrences(of: ":", with: "")
            let numbers = leftOver.components(separatedBy: "|")
            
            guard numbers.count == 2, let valuesString = numbers.first, let winningValuesString = numbers.last else {
                assertionFailure("Not expected")
                return nil
            }
            
            let valuesMatches = RegexMatcher.captureGroups(for: Const.numberRegEx, in: valuesString)
            var values: [Int] = []
            valuesMatches.forEach { match in
                guard let value = match.first?.value, let intValue = Int(value) else { return }
                values.append(intValue)
            }
            
            let winningValuesMatches = RegexMatcher.captureGroups(for: Const.numberRegEx, in: winningValuesString)
            var winningValues: [Int] = []
            winningValuesMatches.forEach { match in
                guard let value = match.first?.value, let intValue = Int(value) else { return }
                winningValues.append(intValue)
            }
            
            return Card(id: idInt, values: values, winningValues: winningValues)
        }
    }
}

// MARK: ConsolePrintable
extension Day_4_2023: ConsolePrintable {
    
    var enableConsolePrint: Bool {
        Self.enableConsolePrint
    }
    
    static var enableConsolePrint: Bool {
        true
    }
}

// MARK: Parser ConsolePrintable
extension Day_4_2023.Parser: ConsolePrintable {
    
    var enableConsolePrint: Bool {
        Self.enableConsolePrint
    }
    
    static var enableConsolePrint: Bool {
        false
    }
}

extension Array: ConsolePrintable where Element == Day_4_2023.Card {
    var enableConsolePrint: Bool {
        Self.enableConsolePrint
    }
    
    static var enableConsolePrint: Bool {
        false
    }
}

private extension Array where Element == Day_4_2023.Card {
    
    var result: Decimal {
        self.reduce(into: 0) { 
            consolePrint("Geometrical progression value: \($1.value)")
            $0 += $1.value
        }
    }
    
    var resultPart2: Int {
        var leftOverCards: [Day_4_2023.Card] = self
        var result = 0
        
        while !leftOverCards.isEmpty {
            var tempGards: [Day_4_2023.Card] = []
            leftOverCards.forEach { card in
                tempGards.append(contentsOf: processCard(card: card, in: self))
            }
            
            leftOverCards = tempGards
            result += leftOverCards.count
        }
        
        return result + self.count
    }
    
    func processCard(card: Day_4_2023.Card,  in cards: [Day_4_2023.Card]) ->  [Day_4_2023.Card] {
        guard card.matchesCount > 0 else { return [] }
        
        let startIndex = card.id
        let endIndex = startIndex + card.matchesCount
        
        let wonCards = Array(cards[startIndex..<endIndex])
        
        consolePrint("Won cards: \(wonCards.map { $0.id })")
        
        return wonCards
    }
}


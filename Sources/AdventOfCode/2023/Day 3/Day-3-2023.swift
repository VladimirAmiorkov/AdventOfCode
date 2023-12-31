//
//  File.swift
//  
//
//  Created by Vladimir Amiorkov on 6.12.23.
//

import Foundation

struct Day_3_2023 {
    
}

// MARK: AdventTaskExecutable
extension Day_3_2023: AdventTaskExecutable {
    
    public func execute(input: Any) -> Any? {
        guard let inputParsed = InputParser.parse(input: input) else { return nil }
        
        let numbers = Parser.getRowResult(lines: inputParsed)
        
        assert(inputParsed.count == numbers.count)
        
        guard !numbers.isEmpty else { return nil }
        
        let answer = Parser.value(from: numbers)
        
        consolePrint("Day 3-2023 part 1 - input: \n\(input)")
        consolePrint("Day 3-2023 part 1 - answer: '\(answer)'")
        
        return answer
    }
    
    func executePartTwo(input: Any) -> Any? {
        guard let inputParsed = InputParser.parse(input: input) else { return nil }
        
        let numbers = Parser.getRowResult(lines: inputParsed)
        
        assert(inputParsed.count == numbers.count)
        
        guard !numbers.isEmpty else { return nil }
        
        var parser = Parser()
        let answer = parser.partTwoValue(from: numbers)
        
        consolePrint("Day 3-2023 part 2 - input: \n\(input)")
        consolePrint("Day 3-2023 part 2 - answer: '\(answer)'")
        
        return answer
    }
}

extension Day_3_2023 {
    
    struct Location: Hashable {
        let row: Int
        let lowerBound: Int
        let upperBound: Int
        var boundsRange: ClosedRange<Int> {
            lowerBound...upperBound
        }
        
        var diagonalBoundsRange: ClosedRange<Int> {
            lowerBound - 1...upperBound + 1
        }
        
        func intersects(with other: Location) -> Bool {
            boundsRange.contains(other.boundsRange) || diagonalBoundsRange.contains(other.boundsRange)
        }
    }
    
    struct Number {
        var value: Int
        let location: Location
    }
    
    struct Symbol: Hashable {
        let value: String
        let location: Location
    }
    
    struct RowResult {
        let numbers: [Number]
        var symbols: [Symbol]
    }
}

// MARK: Parsing
extension Day_3_2023 {
    
    struct Parser {
        
        private enum Const {
            static let numberRegEx = "(\\d+)"
            static let symbolRegEx = "([$&+,:;=?@#|'<>^*()%!/-])"
        }
        
        static func getRowResult(lines: [String]) -> [RowResult] {
            var numbers: [RowResult] = []
            for (index, line) in lines.enumerated() {
                guard let numberMatches = getRowResults(line: line, rowNumber: index) else { continue }
                numbers.append(numberMatches)
            }
            
            return numbers
        }
        
        static func getRowResults(line: String, rowNumber: Int) -> RowResult? {
            let numberMatches = RegexMatcher.captureGroups(for: Const.numberRegEx, in: line)
            var numbers: [Number] = []
            numberMatches.forEach { matches in
                guard let match = matches.last, let intValue = Int(match.value) else { return }
                numbers.append(
                    Number(value: intValue, location: Location(row: rowNumber, lowerBound: match.range.lowerBound,
                                                                upperBound: match.range.upperBound))
                )
            }
            
            let symbolMatches = RegexMatcher.captureGroups(for: Const.symbolRegEx, in: line)
            var symbols: [Symbol] = []
            symbolMatches.forEach { matches in
                guard let match = matches.last else { return }
                symbols.append(
                    Symbol(value: match.value, location: Location(row: rowNumber, lowerBound: match.range.lowerBound,
                                                                  upperBound: match.range.upperBound))
                )
            }
            
            return RowResult(numbers: numbers, symbols: symbols)
        }
        
        static func value(from rowResults: [RowResult]) -> Int {
            var total: Int = 0
            
            for (index, row) in rowResults.enumerated() {
                var adjacentRows: [RowResult] = [row]
                if let prevRow = rowResults[safe: index - 1] {
                    adjacentRows.append(prevRow)
                }
                
                if let nextRow = rowResults[safe: index + 1] {
                    adjacentRows.append(nextRow)
                }
                
                total += value(from: row, in: adjacentRows)
            }
            
            return total
        }
        
        var partTwoCache: [Symbol: [Int]] = [:]
        mutating func partTwoValue(from rowResults: [RowResult]) -> Int {
            for (index, row) in rowResults.enumerated() {
                var adjacentRows: [RowResult] = [row]
                if let prevRow = rowResults[safe: index - 1] {
                    adjacentRows.append(prevRow)
                }
                
                if let nextRow = rowResults[safe: index + 1] {
                    adjacentRows.append(nextRow)
                }
                
                partTwoValue(from: row, in: adjacentRows)
            }
            
            let foundValues = partTwoCache.filter { $0.value.count == 2 }
            
            return foundValues.reduce(into: 0) { partialResult, dict in
                partialResult += dict.value.reduce(1, *)
            }
        }
        
        static func value(from rowResult: RowResult, in rows: [RowResult]) -> Int {
            assert(rows.count >= 2 && rows.count <= 3)
            
            var result = 0
            rowResult.numbers.forEach { number in
                for row in rows {
                    var found = false
                    for symbol in row.symbols {
                        guard number.location.intersects(with: symbol.location) else {
                            consolePrint("DROPPING \(number) when compared to: \(symbol)")
                            continue
                        }
                        
                        result += number.value
                        consolePrint("Found \(number)")
                        found = true
                        break
                    }
                    
                    if found {
                        break
                    }
                }
            }
            
            return result
        }
        
        mutating func partTwoValue(from rowResult: RowResult, in rows: [RowResult]) {
            assert(rows.count >= 2 && rows.count <= 3)
            
            rowResult.numbers.forEach { number in
                for row in rows {
                    for symbol in row.symbols {
                        guard symbol.value == "*" && number.location.intersects(with: symbol.location) else {
                            consolePrint("DROPPING \(number) when compared to: \(symbol)")
                            continue
                        }
                        
                        var values = partTwoCache[symbol] ?? []
                        values.append(number.value)
                        partTwoCache[symbol] = values
                        consolePrint("Found \(number)")
                    }
                }
            }
        }
    }
}

// MARK: ConsolePrintable
extension Day_3_2023: ConsolePrintable {
    
    var enableConsolePrint: Bool {
        Self.enableConsolePrint
    }
    
    static var enableConsolePrint: Bool {
        true
    }
}

// MARK: Parser ConsolePrintable
extension Day_3_2023.Parser: ConsolePrintable {
    
    var enableConsolePrint: Bool {
        Self.enableConsolePrint
    }
    
    static var enableConsolePrint: Bool {
        false
    }
}

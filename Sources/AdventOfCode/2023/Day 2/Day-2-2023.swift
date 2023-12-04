//
//  Day-2-2023.swift
//
//
//  Created by Vladimir Amiorkov on 2.12.23.
//

import Foundation

public struct Day_2_2023 { }


// MARK: AdventTaskExecutable
extension Day_2_2023: AdventTaskExecutable {
    
    public func execute(input: Any) -> Any? {
        guard let inputObj = input as? Input else { return nil }
        guard let input = InputParser.parse(input: inputObj.text) else { return nil }
        
        let question = inputObj.question
        let cubeSets = Parser.parse(lines: input, question: question)
        
        assert(input.count == cubeSets.count)
        
        guard !cubeSets.isEmpty else { return nil }
        
        consolePrint("Day 2-2023 part 1 - input: \n\(input)")
        consolePrint("Day 2-2023 part 1 - answer: '\(cubeSets.resultPart1)'")
        
        return cubeSets.resultPart1
    }
    
    func executePartTwo(input: Any) -> Any? {
        guard let inputObj = input as? Input else { return nil }
        guard let input = InputParser.parse(input: inputObj.text) else { return nil }
        
        let cubeSets = Parser.parse(lines: input, question: nil)
        
        assert(input.count == cubeSets.count)
        
        guard !cubeSets.isEmpty else { return nil }
        
        consolePrint("Day 2-2023 part 2 - input: \n\(input)")
        consolePrint("Day 2-2023 part 2 - answer: '\(cubeSets.resultPart2)'")
        
        return cubeSets.resultPart2
    }
}

extension Day_2_2023 {
    
    struct Input {
        let question: Question
        let text: String
    }
    
    struct Question: CustomStringConvertible {
        let red: Int
        let green: Int
        let blue: Int
        
        var description: String {
            return "Question R: \(red), G: \(green), B: \(blue)"
        }
    }
    
    struct BagResult: CustomStringConvertible {
        let red: Int
        let green: Int
        let blue: Int
        
        var description: String {
            return "BagResult R: \(red), G \(green), B \(blue)"
        }
        
        func isPossible(for question: Question) -> Bool {
            let result = red <= question.red && green <= question.green && blue <= question.blue
            
            consolePrint("Result for question \(question) for set \(self) - \(result)")
            
            return result
        }
    }
    
    struct CubeSet {
        let gameID: Int
        var isPossible: Bool {
            guard let question = question else { return false }
            
            return results.allSatisfy { $0.isPossible(for: question)}
        }
        
        let results: [BagResult]
        let question: Question?
    }
    
    struct Parser {
        
        enum Const {
            static let gameIDRegEx = "Game+\\s(\\d+)"
            static let redRegEx = "(\\d+)\\s+red"
            static let blueRegEx = "(\\d+)\\s+blue"
            static let greenRegEx = "(\\d+)\\s+green"
        }
        
        static func parse(lines: [String], question: Question?) -> [CubeSet] {
            var result: [CubeSet] = []
            lines.forEach { line in
                guard let cubeSet = parse(line: line, question: question) else { return }
                result.append(cubeSet)
            }
            
            return result
        }
        
        static func parse(line: String, question: Question?) -> CubeSet? {
            guard let gameIDSeparatorIndex = line.firstIndex(of: ":") else {
                return nil
            }
            
            let gameIdString = String(line[..<gameIDSeparatorIndex])
            let gameIDMatches = RegexMatcher.captureGroups(for: Const.gameIDRegEx, in: gameIdString)
            
            guard let gameIdStr = gameIDMatches.first?.first, let gameID = Int(gameIdStr)  else { 
                return nil
            }
            
            let leftOver = line.replacingOccurrences(of: gameIdString, with: "")
            
            let games = leftOver.components(separatedBy: ";")
            
            var results: [BagResult] = []
            games.forEach { gameLine in
                guard let result = gameResults(from: gameLine) else { return }
                results.append(result)
            }
            
            return CubeSet(gameID: gameID, results: results, question: question)
        }
        
        static func gameResults(from line: String) -> BagResult? {
            let redMatches = RegexMatcher.captureGroups(for: Const.redRegEx, in: line)
            let greenMatches = RegexMatcher.captureGroups(for: Const.greenRegEx, in: line)
            let blueMatches = RegexMatcher.captureGroups(for: Const.blueRegEx, in: line)
            let red = readMatches(redMatches.flatMap { $0 })
            let green = readMatches(greenMatches.flatMap { $0 })
            let blue = readMatches(blueMatches.flatMap { $0 })
            
            let set = BagResult(red: red, green: green, blue: blue)
            consolePrint("Parsed \(line) to \(set)")
            
            return set
        }
        
        static private func readMatches(_ matches: [String]) -> Int {
            var result = 0
            matches.forEach { match in
                guard let intValue = Int(match) else { return }
                result += intValue
            }
            
            return result
        }
    }
}

// MARK: ConsolePrintable
extension Day_2_2023: ConsolePrintable {
    
    var enableConsolePrint: Bool {
        Self.enableConsolePrint
    }
    
    static var enableConsolePrint: Bool {
        true
    }
}

// MARK: Parser ConsolePrintable
extension Day_2_2023.Parser: ConsolePrintable {
    
    var enableConsolePrint: Bool {
        Self.enableConsolePrint
    }
    
    static var enableConsolePrint: Bool {
        false
    }
}

// MARK: BagResult ConsolePrintable
extension Day_2_2023.BagResult: ConsolePrintable {
    
    var enableConsolePrint: Bool {
        Self.enableConsolePrint
    }
    
    static var enableConsolePrint: Bool {
        false
    }
}

private extension Array where Element == Day_2_2023.CubeSet {
    
    private struct Result {
        let gameId: Int
    }
    
    var resultPart1: Int {
        var result = 0
        self.forEach { cuberSet in
            guard cuberSet.isPossible else { return }
            
            result += cuberSet.gameID
        }
        
        return result
    }
    
    var resultPart2: Int {
        var result = 0
        self.forEach { cuberSet in
            var maxRed = 0
            var maxGreen = 0
            var maxBlue = 0
            cuberSet.results.forEach { bagResult in
                maxRed = bagResult.red < maxRed ? maxRed : bagResult.red
                maxGreen = bagResult.green < maxGreen ? maxGreen : bagResult.green
                maxBlue = bagResult.blue < maxBlue ? maxBlue : bagResult.blue
            }
            
            result += maxRed * maxGreen * maxBlue
        }
        
        return result
    }
}

private extension Array where Element == Day_2_2023.BagResult {
    
    var red: Int {
        reduce(into: 0) { partialResult, result in
            partialResult += result.red
        }
    }
    
    var green: Int {
        reduce(into: 0) { partialResult, result in
            partialResult += result.green
        }
    }
    
    var blue: Int {
        reduce(into: 0) { partialResult, result in
            partialResult += result.blue
        }
    }
}

//
//  Day-2-2023Tests.swift
//  
//
//  Created by Vladimir Amiorkov on 2.12.23.
//

import XCTest
@testable import AdventOfCode

final class Day_2_2023Tests: XCTestCase {

    private var sut: Day_2_2023!
    
    override func setUpWithError() throws {
        sut = Day_2_2023()
    }

    func testTestInput() throws {
        let input = Day_2_2023.Input(question: Day_2_2023.testQuestion, text: Day_2_2023.testInput)
        let answer = try XCTUnwrap(sut.execute(input: input) as? Int)
        
        let expected = 8
        
        XCTAssertEqual(answer, expected)
    }
    
    func testRealInput() throws {
        let input = Day_2_2023.Input(question: Day_2_2023.question, text: Day_2_2023.input)
        let answer = try XCTUnwrap(sut.execute(input: input) as? Int)
        
        let expected = 2727
        
        XCTAssertEqual(answer, expected)
    }
    
    func testPerformanceExecute() throws {
        self.measure {
            _ = sut.execute(input: Day_2_2023.input)
        }
    }
    
    func testPartTwoTestInput() throws {
        let input = Day_2_2023.Input(question: Day_2_2023.question, text: Day_2_2023.testInputPart2)
        let answer = try XCTUnwrap(sut.executePartTwo(input: input) as? Int)
        
        let expected = 2286
        
        XCTAssertEqual(answer, expected)
    }
    
    func testPartTwoRealInput() throws {
        let input = Day_2_2023.Input(question: Day_2_2023.question, text: Day_2_2023.input)
        let answer = try XCTUnwrap(sut.executePartTwo(input: input) as? Int)
        
        let expected = 56580
        
        XCTAssertEqual(answer, expected)
    }
    
    func testPerformanceExecutePart2() throws {
        self.measure {
            _ = sut.executePartTwo(input: Day_2_2023.input)
        }
    }
    
    
    // MARK: Parsing tests
    
    func testZeroSetParser() throws {
        let input = "Game 0: 0 blue, 0 red; 0 red, 0 green, 0 blue; 0 green"
        let set = try XCTUnwrap(Day_2_2023.Parser.parse(line: input, question: Day_2_2023.question))
        
        XCTAssertEqual(set.gameID, 0)
    }
    
    func testSingleDigitSetParser() throws {
        let input = "Game 1: 1 blue, 1 red; 1 red, 1 green, 1 blue; 1 green"
        let set = try XCTUnwrap(Day_2_2023.Parser.parse(line: input, question: Day_2_2023.question))
        
        XCTAssertEqual(set.gameID, 1)
    }
    
    func testDoubleDigitSetParser() throws {
        let input = "Game 10: 10 blue, 10 red; 10 red, 10 green, 10 blue; 10 green"
        let set = try XCTUnwrap(Day_2_2023.Parser.parse(line: input, question: Day_2_2023.question))
        
        XCTAssertEqual(set.gameID, 10)
    }
    
    func testSetsParser() throws {
        let input = try XCTUnwrap(InputParser.parse(input: Day_2_2023.testInput))
        let set = try XCTUnwrap(Day_2_2023.Parser.parse(lines: input, question: Day_2_2023.question))
        
        XCTAssertEqual(set.count, 5)
        
        let first = set[0]
        XCTAssertEqual(first.gameID, 1)
        
        let second = set[1]
        XCTAssertEqual(second.gameID, 2)
    }
}

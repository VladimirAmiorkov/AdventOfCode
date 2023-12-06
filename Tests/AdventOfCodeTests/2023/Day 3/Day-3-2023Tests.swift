//
//  Day-3-2023Tests.swift
//  
//
//  Created by Vladimir Amiorkov on 6.12.23.
//

import XCTest
@testable import AdventOfCode

final class Day_3_2023Tests: XCTestCase {

   
    private var sut: Day_3_2023!
    
    override func setUpWithError() throws {
        sut = Day_3_2023()
    }

    func testTestInput() throws {
        let answer = try XCTUnwrap(sut.execute(input: Day_3_2023.testInput) as? Int)
        
        let expected = 4361
        
        XCTAssertEqual(answer, expected)
    }
    
    func testRealInput() throws {
        let answer = try XCTUnwrap(sut.execute(input: Day_3_2023.input) as? Int)
        
        // 474006
        let expected = 0
        
        XCTAssertEqual(answer, expected)
    }
    
    func testPerformanceExecute() throws {
        self.measure {
            _ = sut.execute(input: Day_3_2023.input)
        }
    }
    
    func testPartTwoTestInput() throws {
        
    }
    
    func testPartTwoRealInput() throws {
        
    }
    
    func testPerformanceExecutePart2() throws {
        self.measure {
            _ = sut.executePartTwo(input: Day_3_2023.input)
        }
    }
    
    // MARK: Parsing tests
    func testParser() throws {
        let input = try XCTUnwrap(InputParser.parse(input: Day_3_2023.testInput))
        let numbers = try XCTUnwrap(Day_3_2023.Parser.getRowResult(lines: input))
        
        XCTAssertEqual(numbers.count, 10)
        
        let value = try XCTUnwrap(Day_3_2023.Parser.value(from: numbers))
        
        XCTAssertEqual(value, 4361)
    }
}

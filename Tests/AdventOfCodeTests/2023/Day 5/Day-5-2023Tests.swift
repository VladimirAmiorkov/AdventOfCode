//
//  Day-5-2023Tests.swift
//  
//
//  Created by Vladimir Amiorkov on 9.12.23.
//

import XCTest
@testable import AdventOfCode

final class Day_5_2023Tests: XCTestCase {

    private var sut: Day_5_2023!
    
    override func setUpWithError() throws {
        sut = Day_5_2023()
    }

    func testTestInput() throws {
        let answer = try XCTUnwrap(sut.execute(input: Day_5_2023.testInput) as? Decimal)
        
        let expected = Decimal(13)
        
        XCTAssertEqual(answer, expected)
    }
    
    func testTestInput2() throws {
        let answer = try XCTUnwrap(sut.execute(input: Day_5_2023.testInput2) as? Decimal)
        
        let expected = Decimal(0)
        
        XCTAssertEqual(answer, expected)
    }
    
    func testRealInput() throws {
        let answer = try XCTUnwrap(sut.execute(input: Day_5_2023.input) as? Decimal)
        
        let expected = Decimal(25571)
        
        XCTAssertEqual(answer, expected)
    }
    
    func testPerformanceExecute() throws {
        self.measure {
            _ = sut.execute(input: Day_4_2023.input)
        }
    }
    
    func testPartTwoTestInput() throws {
        let answer = try XCTUnwrap(sut.executePartTwo(input: Day_5_2023.testInput) as? Int)
        
        let expected = Int(30)
        
        XCTAssertEqual(answer, expected)
    }
    
    /// Running this test take around 2 mins, enable if desired
    func testPartTwoRealInput() throws {
        let answer = try XCTUnwrap(sut.executePartTwo(input: Day_5_2023.input) as? Int)
        
        let expected = Int(8805731)
        
        XCTAssertEqual(answer, expected)
    }
    
    /// Running this test take around 2 mins, enable if desired
    func testPerformanceExecutePart2() throws {
        self.measure {
            _ = sut.executePartTwo(input: Day_4_2023.input)
        }
    }
    
    // MARK: Parsing tests

}

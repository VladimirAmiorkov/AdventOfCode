//
//  Day-4-2023Tests.swift
//
//
//  Created by Vladimir Amiorkov on 6.12.23.
//

import XCTest
@testable import AdventOfCode

final class Day_4_2023Tests: XCTestCase {

    private var sut: Day_4_2023!
    
    override func setUpWithError() throws {
        sut = Day_4_2023()
    }

    func testTestInput() throws {
        let answer = try XCTUnwrap(sut.execute(input: Day_4_2023.testInput) as? Decimal)
        
        let expected = Decimal(13)
        
        XCTAssertEqual(answer, expected)
    }
    
    func testTestInput2() throws {
        let answer = try XCTUnwrap(sut.execute(input: Day_4_2023.testInput2) as? Decimal)
        
        let expected = Decimal(0)
        
        XCTAssertEqual(answer, expected)
    }
    
    func testRealInput() throws {
        let answer = try XCTUnwrap(sut.execute(input: Day_4_2023.input) as? Decimal)
        
        let expected = Decimal(25571)
        
        XCTAssertEqual(answer, expected)
    }
    
    func testPerformanceExecute() throws {
        self.measure {
            _ = sut.execute(input: Day_4_2023.input)
        }
    }
    
    func testPartTwoTestInput() throws {
        let answer = try XCTUnwrap(sut.executePartTwo(input: Day_4_2023.testInput) as? Decimal)
        
        let expected = Decimal(0)
        
        XCTAssertEqual(answer, expected)
    }
    
    func testPartTwoRealInput() throws {
        let answer = try XCTUnwrap(sut.executePartTwo(input: Day_4_2023.input) as? Decimal)
        
        let expected = Decimal(0)
        
        XCTAssertEqual(answer, expected)
    }
    
    func testPerformanceExecutePart2() throws {
        self.measure {
            _ = sut.executePartTwo(input: Day_4_2023.input)
        }
    }
    
    // MARK: Parsing tests
    func testCard() throws {
        let card = Day_4_2023.Card(id: 1, values: [1, 2, 3], winningValues: [1])
        XCTAssertEqual(card.value, 1)
        
        let card2 = Day_4_2023.Card(id: 1, values: [1, 2, 3], winningValues: [1, 2])
        XCTAssertEqual(card2.value, 2)
        
        let card3 = Day_4_2023.Card(id: 1, values: [1, 2, 3], winningValues: [1, 3, 2])
        XCTAssertEqual(card3.value, 4)
        
        let card4 = Day_4_2023.Card(id: 1, values: [1, 2, 3, 4], winningValues: [1, 3, 2, 4])
        XCTAssertEqual(card4.value, 8)
    }
}

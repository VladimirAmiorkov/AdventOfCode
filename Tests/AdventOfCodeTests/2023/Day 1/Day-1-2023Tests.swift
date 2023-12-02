//
//  Day-1-2023Tests.swift
//
//
//  Created by Vladimir Amiorkov on 2.12.23.
//

import XCTest
@testable import AdventOfCode

final class Day_1_2023Tests: XCTestCase {
    
    private var sut: Day_1_2023!
    
    override func setUpWithError() throws {
        sut = Day_1_2023()
    }

    func testTestInput() throws {
        guard let answer = sut.execute(input: Day_1_2023.testInput) as? Int else { return }
        
        let expected = 142
        
        XCTAssertEqual(answer, expected)
    }
    
    func testTestInput2() throws {
        guard let answer = sut.execute(input: Day_1_2023.testInput2) as? Int else { return }
        
        let expected = 281
        
        XCTAssertEqual(answer, expected)
    }
    
    func testRealInput() throws {
        guard let answer = sut.execute(input: Day_1_2023.input) as? Int else { return }
        
        let expected = 55413
        
        XCTAssertEqual(answer, expected)
    }
    
    func testPerformanceExample() throws {
        self.measure {
            _ = sut.execute(input: Day_1_2023.input)
        }
    }
}

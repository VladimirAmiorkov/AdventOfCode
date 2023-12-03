//
//  InputParser.swift
//
//
//  Created by Vladimir Amiorkov on 3.12.23.
//

import Foundation

protocol InputParserProtocol {
    static func parse(input: Any) -> [String]?
}

struct InputParser { }

// MARK: InputParserProtocol
extension InputParser: InputParserProtocol {
    
    static func parse(input: Any) -> [String]? {
        guard let inputString = input as? String else { return nil }
                
        return Array(inputString.lines)
    }
}

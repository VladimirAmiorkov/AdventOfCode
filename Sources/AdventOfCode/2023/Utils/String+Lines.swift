//
//  String+Lines.swift
//
//
//  Created by Vladimir Amiorkov on 2.12.23.
//

import Foundation

extension String {
    var lines: [String] {
        var result: [String] = []
        enumerateLines { line, _ in result.append(line) }
        return result
    }
}

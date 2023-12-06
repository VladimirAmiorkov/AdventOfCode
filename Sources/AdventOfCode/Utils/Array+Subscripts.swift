//
//  Array+Subscripts.swift
//
//
//  Created by Vladimir Amiorkov on 6.12.23.
//

import Foundation

extension Array {
    
    subscript(safe index: Int) -> Element? {
        guard index < endIndex, index >= startIndex else { return nil}
        return self[index]
    }
}

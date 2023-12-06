//
//  File.swift
//  
//
//  Created by Vladimir Amiorkov on 6.12.23.
//

import Foundation

struct Math {
    
    static func geometricProgression(term: Int, firstTerm: Decimal, commonRation: Decimal) -> Decimal {
        let n = term - 1
        
        guard n > 0 else { return 0 }
        
        return firstTerm * (pow(commonRation, n))
    }
}

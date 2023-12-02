//
//  File.swift
//  
//
//  Created by Vladimir Amiorkov on 2.12.23.
//

import Foundation

protocol ConsolePrintable {
    var enableConsolePrint: Bool { get }
    static var enableConsolePrint: Bool { get }
    
    func consolePrint(_ message: String)
}

extension ConsolePrintable {
    
    func consolePrint(_ message: String) {
        guard enableConsolePrint else { return }
        
        print(message)
    }
    
    static func consolePrint(_ message: String) {
        guard Self.enableConsolePrint else { return }
        
        print(message)
    }
}

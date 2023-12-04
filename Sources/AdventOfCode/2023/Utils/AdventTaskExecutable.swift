//
//  AdventTaskExecutable.swift
//
//
//  Created by Vladimir Amiorkov on 2.12.23.
//

import Foundation

protocol AdventTaskExecutable {
    func execute(input: Any) -> Any?
    func executePartTwo(input: Any) -> Any?
}

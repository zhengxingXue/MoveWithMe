//
//  JumpingJack.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 11/16/21.
//

import Foundation

struct JumpingJack: Excercise {
    let name = "Jumping Jack"
    var repetition: Double = 12
    var repCount: Double = 0
    
    mutating func incrementCount() {
        repCount = repCount < repetition ? repCount + 1 : repetition
    }
}

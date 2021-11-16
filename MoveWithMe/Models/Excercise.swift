//
//  Excercise.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 11/16/21.
//

import Foundation

protocol Excercise {
    var name: String { get }
    var repetition: Double { get set }
    var repCount: Double { get set }
    
    mutating func incrementCount()
}

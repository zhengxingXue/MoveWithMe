//
//  Double+.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 10/27/21.
//

import Foundation

extension Double {
    func asNumberString() -> String { String(format: "%.2f", self) }
    
    func asNumberString1Decimal() -> String { String(format: "%.1f", self) }
    
    func asNumberString0Decimal() -> String { String(format: "%.0f", self) }
}

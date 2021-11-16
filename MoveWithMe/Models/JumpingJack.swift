//
//  JumpingJack.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 11/16/21.
//

import SwiftUI

struct JumpingJack: Exercise {
    let name = "Jumping Jack"
    var repetition: Double = 12
    var repCount: Double = 0
    
    private var startConditionSatify: Bool = true
    private var middleConditionSatify: Bool = false
    private var endConditionSatify: Bool = false
    
    mutating func incrementCount(for pose: Pose) {
        if let leftArmAngle = pose.getAngle(origin: .leftShoulder, p2: .leftElbow, p3: .leftHip), let rightArmAngel = pose.getAngle(origin: .rightShoulder, p2: .rightElbow, p3: .rightHip) {
            
            if startConditionSatify {
                if leftArmAngle > Angle(degrees: 150) && rightArmAngel > Angle(degrees: 150) {
                    startConditionSatify = false
                    middleConditionSatify = true
                }
                return
            }
            
            if middleConditionSatify {
                if leftArmAngle < Angle(degrees: 30) && rightArmAngel < Angle(degrees: 30) {
                    middleConditionSatify = false
                    endConditionSatify = true
                }
                return
            }
            
            if endConditionSatify {
                repCount = repCount < repetition ? repCount + 1 : repetition
                endConditionSatify = false
                startConditionSatify = true
                return
            }
        }
    }
}

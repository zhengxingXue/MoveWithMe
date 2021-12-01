//
//  Squat.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 11/30/21.
//

import Foundation

struct Squat: Exercise {
    let name = "Squat"
    var repetition: Double = 12
    var repCount: Double = 0
    
    private var wasInBottom: Bool = false
    
    mutating func incrementCount(for pose: Pose) {
        if pose[.rightKnee].isValid && pose[.leftKnee].isValid && pose[.rightHip].isValid && pose[.leftHip].isValid {
            let rightKnee = pose[.rightKnee].position
            let leftKnee = pose[.leftKnee].position
            let rightHip = pose[.rightHip].position
            let leftHip = pose[.leftHip].position
            
            let hipHeight = rightHip.y + leftHip.y
            let kneeHeight = rightKnee.y + leftKnee.y
            
            print("\(rightHip.y) \(leftHip.y) \(rightKnee.y) \(leftKnee.y)")
            
            if hipHeight < kneeHeight - 10 {
                wasInBottom = true
            } else {
                if wasInBottom {
                    repCount = repCount < repetition ? repCount + 1 : repetition
                    wasInBottom = false
                }
            }
        }
    }
}

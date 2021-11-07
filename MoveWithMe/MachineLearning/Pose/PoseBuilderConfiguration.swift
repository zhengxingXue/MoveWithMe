/*
Source: https://developer.apple.com/documentation/coreml/detecting_human_body_poses_in_an_image
*/

import CoreGraphics

enum Algorithm: Int {
    case single
    case multiple
}

struct PoseBuilderConfiguration {
    /// The minimum value for valid joints in a pose.
    var jointConfidenceThreshold: Double = 0.5

    /// The minimum value for a valid pose.
    var poseConfidenceThreshold: Double = 0.5

    /// The minimum distance between two distinct joints of the same type.
    ///
    /// - Note: This parameter only applies to the multiple-pose algorithm.
    var matchingJointDistance: Double = 40.0

    /// Search radius used when checking if a joint has the greatest confidence amongst its neighbors.
    ///
    /// - Note: This parameter only applies to the multiple-pose algorithm.
    var localSearchRadiusDouble: Double = 3
    var localSearchRadius: Int { Int(localSearchRadiusDouble) }

    /// The maximum number of poses returned.
    ///
    /// - Note: This parameter only applies to the multiple-pose algorithm.
    var maxPoseCountDouble: Double = 15
    var maxPoseCount: Int { Int(maxPoseCountDouble) }

    /// The number of iterations performed to refine an adjacent joint's position.
    ///
    /// - Note: This parameter only applies to the multiple-pose algorithm.
    var adjacentJointOffsetRefinementStepsDouble: Double = 3
    var adjacentJointOffsetRefinementSteps: Int { Int(adjacentJointOffsetRefinementStepsDouble) }
}

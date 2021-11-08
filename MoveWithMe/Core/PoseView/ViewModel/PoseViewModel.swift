//
//  PoseViewModel.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 9/27/21.
//

import AVFoundation
import UIKit
import VideoToolbox
import SwiftUI

class PoseViewModel: NSObject, ObservableObject {
    @Published var previewImageView = PoseNetImageView()
    
    /// The algorithm the controller uses to extract poses from the current frame.
    @Published var algorithm: Algorithm = .multiple
    
    /// The set of parameters passed to the pose builder when detecting poses.
    @Published var poseBuilderConfiguration = PoseBuilderConfiguration()
    
    @Published var leftArmAngle: Angle? = .none
    
    /// Keep track if in setting view, if in setting view, stop updating angle variable 
    var inSettingView: Bool = false
    
    private let videoCapture = VideoCapture()
    
    private var poseNet: PoseNet!
    
    /// The frame the PoseNet model is currently making pose predictions from.
    private var currentFrame: CGImage?
    
    private var currentPose: Pose? = nil {
        didSet {
            if !inSettingView, let pose = currentPose {
                leftArmAngle = pose.getAngle(origin: .leftShoulder, p2: .leftElbow, p3: .leftHip)
            }
        }
    }
    
    override init() {
        super.init()
        
        // For convenience, the idle timer is disabled to prevent the screen from locking.
        UIApplication.shared.isIdleTimerDisabled = true
        
        do {
            poseNet = try PoseNet()
        } catch {
            fatalError("Failed to load model. \(error.localizedDescription)")
        }
        poseNet.delegate = self
        setupAndBeginCapturingVideoFrames()
    }
    
    func flipCamera() {
        videoCapture.flipCamera { error in
            if let error = error {
                print("Failed to flip camera with error \(error)")
            }
        }
    }
    
    func setupAndBeginCapturingVideoFrames() {
        videoCapture.setUpAVCapture { error in
            if let error = error {
                print("Failed to setup camera with error \(error)")
                return
            }
            
            self.videoCapture.delegate = self
            
            self.videoCapture.startCapturing()
        }
    }
    
    func stopCapturing() {
        videoCapture.stopCapturing()
    }
}

// MARK: - VideoCaptureDelegate

extension PoseViewModel: VideoCaptureDelegate {
    func videoCapture(_ videoCapture: VideoCapture, didCaptureFrame capturedImage: CGImage?) {
        guard currentFrame == nil else {
            return
        }
        guard let image = capturedImage else {
            fatalError("Captured image is null")
        }
        
        currentFrame = image
        poseNet.predict(image)
    }
}

// MARK: - PoseNetDelegate

extension PoseViewModel: PoseNetDelegate {
    func poseNet(_ poseNet: PoseNet, didPredict predictions: PoseNetOutput) {
        defer {
            // Release `currentFrame` when exiting this method.
            self.currentFrame = nil
        }
        
        guard let currentFrame = currentFrame else {
            return
        }
        
        let poseBuilder = PoseBuilder(output: predictions,
                                      configuration: poseBuilderConfiguration,
                                      inputImage: currentFrame)
        
        let poses = algorithm == .single ? [poseBuilder.pose] : poseBuilder.poses
        
        self.currentPose = poses.first
        
        previewImageView.show(poses: poses, on: currentFrame)
    }
}


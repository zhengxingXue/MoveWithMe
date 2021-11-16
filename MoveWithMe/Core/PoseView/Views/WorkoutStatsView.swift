//
//  WorkoutStatsView.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 11/12/21.
//

import SwiftUI

struct WorkoutStatsView: View {
    
    @EnvironmentObject var poseVM: PoseViewModel
    
    var body: some View {
        if isiPad {
            iPadTabView
        } else if isiPhone {
            iPhoneTabView
        } else {
            EmptyView()
        }
    }
}

struct WorkoutStatsView_Previews: PreviewProvider {
    static var previews: some View {
//        PoseView()
//            .preferredColorScheme(.light)
//            .previewDevice("iPad Pro (11-inch) (3rd generation)")
//            .previewInterfaceOrientation(.landscapeLeft)
        PoseView()
            .previewDevice("iPhone 11 Pro Max")
    }
}

extension WorkoutStatsView {
    
    // MARK: iPad
    private var iPadTabView: some View {
        TabView {
            iPadRepCountView
            iPadCircleIndicatorWithFigureView
        }
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.6))
        )
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: 300, height: 200)
    }
    
    private var iPadRepCountView: some View {
        HStack(spacing: 0) {
            makeRepCountIndicator(for: poseVM.exercise)
                .padding(30)
                .font(.system(size: 70))
        }
    }
    
    private var iPadCircleIndicatorWithFigureView: some View {
        HStack(spacing: 10) {
            VStack(spacing: 20) {
                makeCircleIndicator(angle: poseVM.rightArmAngel)
                makeCircleIndicator(angle: poseVM.rightLegAngle)
            }
            
            Image(systemName: "figure.walk")
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 20) {
                makeCircleIndicator(angle: poseVM.leftArmAngle)
                makeCircleIndicator(angle: poseVM.leftLegAngel)
            }
        }
        .padding()
    }
    
    // MARK: iPhone
    private var iPhoneTabView: some View {
        TabView {
            iPhoneRepCountView
            iPhoneCircleIndicatorWithFigureView
        }
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.6))
        )
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: 150, height: 150)
    }
    
    private var iPhoneRepCountView: some View {
        HStack(spacing: 0) {
            makeRepCountIndicator(for: poseVM.exercise, lineWidth: 10)
                .padding(30)
                .font(.system(size: 40))
        }
    }
    
    private var iPhoneCircleIndicatorWithFigureView: some View {
        HStack(spacing: 10) {
            VStack(spacing: 20) {
                makeCircleIndicator(angle: poseVM.rightArmAngel, lineWidth: 6)
                makeCircleIndicator(angle: poseVM.rightLegAngle, lineWidth: 6)
            }
            VStack(spacing: 20) {
                makeCircleIndicator(angle: poseVM.leftArmAngle, lineWidth: 6)
                makeCircleIndicator(angle: poseVM.leftLegAngel, lineWidth: 6)
            }
        }
        .padding()
    }
    
    // MARK: View Builder
    @ViewBuilder private func makeRepCountIndicator(for exercise: Exercise, color: Color = .orange, lineWidth: CGFloat = 16) -> some View {
        CircleIndicator(
            data: exercise.repCount,
            upperBound: exercise.repetition,
            showData: true,
            color: color,
            lineWidth: lineWidth
        )
    }
    
    @ViewBuilder private func makeCircleIndicator(angle: Angle?, showData: Bool = false, lineWidth: CGFloat = 10) -> some View {
        CircleIndicator(
            data: (angle?.degrees ?? 90),
            upperBound: 180,
            showData: showData,
            color: .orange,
            lineWidth: lineWidth
        )
    }
    
}

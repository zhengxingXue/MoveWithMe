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
        } else {
            EmptyView()
        }
    }
}

struct WorkoutStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PoseView()
            .preferredColorScheme(.light)
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

extension WorkoutStatsView {
    
    private var iPadTabView: some View {
        TabView {
            repCountView
            circleIndicatorWithFigureView
        }
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.6))
        )
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: 300, height: 200)
    }
    
    private var repCountView: some View {
        HStack(spacing: 0) {
            makeRepCountIndicator(for: poseVM.exercise)
                .padding(30)
                .font(.system(size: 70))
            
//            Button {
//                poseVM.incrementExcerciseRep()
//                print("DEBUG: rep count is \(poseVM.exercise.repCount)")
//            } label: {
//                Image(systemName: "plus")
//            }
//            .padding()

        }
    }
    
    @ViewBuilder private func makeRepCountIndicator(for excercise: Excercise, color: Color = .orange, lineWidth: CGFloat = 16) -> some View {
        CircleIndicator(
            data: excercise.repCount,
            upperBound: excercise.repetition,
            showData: true,
            color: color,
            lineWidth: lineWidth
        )
    }
    
    private var circleIndicatorWithFigureView: some View {
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
    
    @ViewBuilder private func makeCircleIndicator(angle: Angle?, showData: Bool = false) -> some View {
        CircleIndicator(
            data: (angle?.degrees ?? 90),
            upperBound: 180,
            showData: showData,
            color: .orange,
            lineWidth: 10
        )
    }
    
}

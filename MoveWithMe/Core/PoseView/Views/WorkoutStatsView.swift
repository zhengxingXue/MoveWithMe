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
            iPadStatsView
        } else {
            EmptyView()
        }
    }
    
    private var iPadStatsView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.6))
            VStack {
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
                Spacer()
//                HStack {
//                    Spacer()
//                    Button {
//                        print("DEBUG: Collapse stats section")
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 10)
//                    }
//                }
            }
            .foregroundColor(.white)
            .padding()
        }
        .frame(width: 300, height: 200)
    }
    
    @ViewBuilder
    private func makeCircleIndicator(angle: Angle?, showData: Bool = false) -> some View {
        CircleIndicator(
            data: (angle?.degrees ?? 90),
            showData: showData,
            color: .orange,
            lineWidth: 10,
            trimRatio: (angle?.degrees ?? 90) / 180
        )
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

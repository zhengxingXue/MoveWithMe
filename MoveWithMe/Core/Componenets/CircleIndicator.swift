//
//  CircleIndicator.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 11/8/21.
//

import SwiftUI

struct CircleIndicator: View {
    
    var color: Color
    var lineWidth: CGFloat
    var trimRatio: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.3), lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: trimRatio)
                .rotation(Angle(degrees: -90))
            .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
        }
    }
}

struct CircleIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CircleIndicator(color: .orange, lineWidth: 10, trimRatio: 0.5)
            .padding()
    }
}

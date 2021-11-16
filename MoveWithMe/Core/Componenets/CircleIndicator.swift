//
//  CircleIndicator.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 11/8/21.
//

import SwiftUI

struct CircleIndicator: View {
    
    var data: Double
    var upperBound: Double
    var showData: Bool
    var color: Color
    var lineWidth: CGFloat
    
    var body: some View {
        ZStack {
            if showData {
                Text(data.asNumberString0Decimal())
                    .animation(.none)
            }
            Circle()
                .stroke(color.opacity(0.3), lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: CGFloat(data / upperBound))
                .rotation(Angle(degrees: -90))
            .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
        }
        .animation(.linear, value: data)
    }
}

struct CircleIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CircleIndicator(data: 90.0, upperBound: 180, showData: true, color: .orange, lineWidth: 10)
            .padding()
    }
}

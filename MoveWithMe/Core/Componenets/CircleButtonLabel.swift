//
//  CircleButtonLabel.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 10/28/21.
//

import SwiftUI

struct CircleButtonLabel: View {
    let systemName: String
    let buttonFillColor: Color
    let circleSize: CGFloat
    
    init(
        systemName: String,
        buttonFillColor: Color = Color.black.opacity(0.6),
        circleSize: CGFloat = 50
    ) {
        self.systemName = systemName
        self.buttonFillColor = buttonFillColor
        self.circleSize = circleSize
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(buttonFillColor)
                .frame(width: circleSize, height: circleSize)
            Image(systemName: systemName)
                .font(.system(size: circleSize / 2))
                .foregroundColor(.white)
        }
    }
}

struct CircleButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CircleButtonLabel(systemName: "xmark")
            CircleButtonLabel(systemName: "gearshape", circleSize: 60)
            CircleButtonLabel(systemName: "gearshape", circleSize: 30)
        }
    }
}

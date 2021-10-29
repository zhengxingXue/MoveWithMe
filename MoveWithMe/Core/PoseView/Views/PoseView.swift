//
//  PoseView.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 10/28/21.
//

import SwiftUI

struct PoseView: View {
    @StateObject var poseVM = PoseViewModel()
    
    @State var orientation = UIDevice.current.orientation
    
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    Spacer()
                }
                Spacer()
                Text("Hello")
            }
            .background(
                PoseNetView(vm: poseVM)
                    .ignoresSafeArea()
            )
        }
        .onReceive(orientationChanged) { _ in
            if UIDevice.current.localizedModel == "iPad" {
                self.poseVM.setupAndBeginCapturingVideoFrames()
            }
        }
        .onDisappear {
            self.poseVM.stopCapturing()
        }
    }
}

struct PoseView_Previews: PreviewProvider {
    static var previews: some View {
        PoseView()
    }
}

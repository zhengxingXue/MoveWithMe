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
    @State var showButtons: Bool = true
    @State var showSettingView: Bool = false
    
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                topSectionView
                Spacer()
                bottomSectionView
            }
            .padding(.horizontal, isiPad ? 39 : 20)
            .padding(.vertical, 20)
            .background(
                PoseNetView(vm: poseVM)
                    .ignoresSafeArea()
            )
        }
        .sheet(isPresented: $showSettingView, content: {
            PoseNetSettingView(vm: poseVM, showSettingView: $showSettingView)
        })
        .onReceive(orientationChanged) { _ in
            if isiPad { self.poseVM.setupAndBeginCapturingVideoFrames() }
        }
        .onDisappear { self.poseVM.stopCapturing() }
    }
}

struct PoseView_Previews: PreviewProvider {
    static var previews: some View {
        PoseView()
            .preferredColorScheme(.light)
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .previewInterfaceOrientation(.landscapeLeft)
        PoseView()
            .previewDevice("iPhone 11 Pro Max")
    }
}

extension PoseView {
    // MARK: Top Section
    private var topSectionView: some View {
        HStack(alignment: .top) {
            if isiPad {
                iPadStatsView
            }
            Spacer()
            Button {
                print("DEBUG: exit button clicked")
            } label: {
                CircleButtonLabel(systemName: "xmark")
            }
        }
    }
    
    private var iPadStatsView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.6))
            VStack {
                HStack {
                    Text("16:37")
                    Spacer()
                }
                HStack(alignment: .center, spacing: 0) {
                    Text("136")
                    Image(systemName: "heart.fill")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Spacer()
                }
                HStack(alignment: .center, spacing: 0) {
                    Text("142")
                    Text("CAL")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Spacer()
                }
                Spacer()
                HStack {
                    ZStack {
                        Circle()
                            .stroke(Color.orange.opacity(0.3), lineWidth: 10)
                        Circle()
                            .trim(from: 0, to: 0.8)
                            .rotation(Angle(degrees: -90))
                        .stroke(Color.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    }
                }
            }
            .font(.system(size: 50))
            .foregroundColor(.white)
            .padding()
        }
        .frame(width: 230, height: 300)
    }
    
    // MARK: Bottom Section
    private var bottomSectionView: some View {
        HStack {
            Spacer()
            VStack {
                if showButtons {
                    Button {
//                        print("DEBUG: setting button clicked")
                        showSettingView.toggle()
                    } label: {
                        CircleButtonLabel(systemName: "gearshape")
                    }
                    Button {
//                        print("DEBUG: flip camera button clicked")
                        poseVM.flipCamera()
                    } label: {
                        CircleButtonLabel(systemName: "arrow.triangle.2.circlepath")
                    }
                }
                Button {
                    withAnimation() {
                        showButtons.toggle()
                    }
                } label: {
                    CircleButtonLabel(systemName: "chevron.up")
                }
                .rotationEffect(.init(degrees: showButtons ? 180 : 0))
            }
            .cornerRadius(25)
        }
    }
    
}

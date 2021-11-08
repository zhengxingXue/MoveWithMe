//
//  PoseNetSettingView.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 10/28/21.
//

import SwiftUI

struct PoseNetSettingView: View {
    
    @Binding private var showSettingView: Bool
    
    @ObservedObject var vm: PoseViewModel
    
    init(vm: PoseViewModel, showSettingView: Binding<Bool>) {
        self.vm = vm
        self._showSettingView = showSettingView
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                Form {
                    Section(header: Text("Pose Net")) {
                        
                        Picker("Algorithm", selection: $vm.algorithm) {
                            Text("Single Pose").tag(Algorithm.single)
                            Text("Multiple Poses").tag(Algorithm.multiple)
                        }
                        .pickerStyle(.segmented)
                        
                        makePoseNetConfigurationRow(
                            name: "Joint Confidence Threshold",
                            value: $vm.poseBuilderConfiguration.jointConfidenceThreshold,
                            range: 0...1,
                            step: 0.1,
                            proxy: proxy
                        )
                        
                        makePoseNetConfigurationRow(
                            name: "Pose Confidence Threshold",
                            value: $vm.poseBuilderConfiguration.poseConfidenceThreshold,
                            range: 0...1,
                            step: 0.1,
                            proxy: proxy
                        )
                        
                        if vm.algorithm == .multiple {
                            makePoseNetConfigurationRow(
                                name: "Matching Joint Distance",
                                value: $vm.poseBuilderConfiguration.matchingJointDistance,
                                range: 0...100,
                                step: 0.1,
                                proxy: proxy
                            )
                            
                            makePoseNetConfigurationRow(
                                name: "Local Joint Search Radius",
                                value: $vm.poseBuilderConfiguration.localSearchRadiusDouble,
                                range: 0...10,
                                step: 1,
                                proxy: proxy
                            )
                            
                            makePoseNetConfigurationRow(
                                name: "Adjacent Joint Refinement Steps",
                                value: $vm.poseBuilderConfiguration.adjacentJointOffsetRefinementStepsDouble,
                                range: 0...7,
                                step: 1,
                                proxy: proxy
                            )
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Configuration")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        vm.algorithm = .multiple
                        vm.poseBuilderConfiguration = PoseBuilderConfiguration()
                    } label: {
                        Text("Reset")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettingView = false
                    } label: {
                        Text("close")
                    }
                }
            }
        }
        .onDisappear {
            vm.inSettingView = false
//            print("DEBUG: Setting View closed")
        }
    }
    
    @ViewBuilder
    private func makePoseNetConfigurationRow(
        name: String,
        value: Binding<Double>,
        range: ClosedRange<Double>,
        step: Double,
        proxy: GeometryProxy
    ) -> some View {
        if isiPad {
            HStack {
                Text(name + " (\(value.wrappedValue.asNumberString1Decimal()))")
                Spacer()
                Slider(value: value, in: range, step: step)
                    .frame(width: proxy.size.width / 2, alignment: .trailing)
            }
        }
        else if isiPhone {
            VStack(alignment: .leading, spacing: 0) {
                Text(name + " (\(value.wrappedValue.asNumberString1Decimal()))")
                Slider(value: value, in: range, step: step)
            }
        }
    }
}

struct PoseNetSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PoseView()
            .preferredColorScheme(.light)
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

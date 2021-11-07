//
//  PoseNetView.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 9/27/21.
//

import SwiftUI

struct PoseNetView: UIViewRepresentable {
    @ObservedObject var vm: PoseViewModel
    
    func makeUIView(context: Context) -> some UIView {
        let view = vm.previewImageView
        view.contentMode = .scaleAspectFill
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

//
//  View+.swift
//  MoveWithMe
//
//  Created by Jim's MacBook Pro on 10/28/21.
//

import SwiftUI

extension View {
    var isiPad: Bool { UIDevice.current.localizedModel == "iPad" }
    
    var isiPhone: Bool { UIDevice.current.localizedModel == "iPhone" }
}

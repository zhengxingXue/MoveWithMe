//
//  Color+.swift
//  Color+
//
//  Created by Jim's MacBook Pro on 9/2/21.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryText = Color("SecondaryTextColor")
}

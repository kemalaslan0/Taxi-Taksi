//
//  Color.swift
//  Taksi
//
//  Created by Kemal Aslan on 12.01.2024.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
        let backgroundColor = Color("BackgroundColor")
        let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
        let primaryTextColor = Color("PrimaryTextColor")
}

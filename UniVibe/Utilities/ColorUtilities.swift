//
//  ColorUtilities.swift
//  UniVibe
//
//  Created by Taha Al on 8/24/23.
//

import Foundation

import SwiftUI

final class ColorUtilities {
    
    static func dynamicBackgroundColor(for colorScheme: ColorScheme) -> Color {
        return colorScheme == .dark ? Color.black : Color.white
    }
    
    
    static func dynamicForgroundColor(for colorScheme: ColorScheme) -> Color {
        return colorScheme == .dark ? Color.white : Color.black
    }
    
}

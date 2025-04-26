//
//  SettingsController.swift
//  Roulette
//
//  Created by Frankly on 19/03/25.
//

import SwiftUI

class SettingsController: ObservableObject {
    @Published var sound: Bool = false
    @Published var selectedMode: Constants.ColorMode.Theme = .system
    @Published var dynamicSize = max(Constants.ScreenSize.screenSize.width, Constants.ScreenSize.screenSize.height) * 1.2

    @Published var hapticFeedback: Bool = true
    @Published var animationDuration: Double = 10
    
    func resetSettings() {
        sound = false
        selectedMode = .system
        hapticFeedback = true
        animationDuration = 10
    }
}

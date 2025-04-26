//
//  SpinningBackgroundController.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import Foundation
import SwiftUI

class SpinningBackgroundController: ObservableObject {
    @Published var rotationAngle: Double = 0
    @Published var isAnimating: Bool = true

    
    var dynamicSize: CGFloat {
        max(Constants.ScreenSize.screenSize.width, Constants.ScreenSize.screenSize.height) * 1.2
    }

    let opacity: Double = 0.1
    let numSections: Int = 40
    let colors: [Color] = ComponentColors.backgroundSegments

    func startAnimation() {
        guard isAnimating else { return }

        withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
    }

    func toggleAnimation() {
        isAnimating.toggle()
        if isAnimating {
            startAnimation()
        } else {
            rotationAngle = 0
        }
    }
}

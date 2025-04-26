//
//  SpinnerController.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import Foundation
import SwiftUI

class SpinnerController: ObservableObject {
    let size: CGFloat
    let items: [String?]
    let numSections: Int
    let colors: [Color]

    @Published var rotationAngle: Double = 0
    @Published var lastRotation: Double = 0
    @Published var angularVelocity: Double = 0
    @Published var isInteractionDisabled: Bool = false
    private var decelerationTimer: Timer?

    lazy var colorDistribution: [Color] = distributeColorsEvenly(colors, count: numSections)

    init(size: CGFloat, items: [String?]?, numSections: Int?, colors: [Color]) {
        self.size = size
        self.items = items ?? []
        self.numSections = numSections ?? self.items.count
        self.colors = colors
    }

    var options: [SpinnerOptionModel] {
        let segmentSize = 360.0 / Double(numSections)

        return (0..<numSections).map { index in
            let start = segmentSize * Double(index)
            let end = start + segmentSize

            return SpinnerOptionModel(
                startAngle: start,
                endAngle: end,
                color: colorDistribution[index],
                text: items.indices.contains(index) ? items[index] : nil,
                size: size
            )
        }
    }

    func startDeceleration(completion: (() -> Void)? = nil) {
        decelerationTimer?.invalidate()
        var currentVelocity = angularVelocity
        let friction: Double = 0.985

        decelerationTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            if abs(currentVelocity) < 0.05 {
                timer.invalidate()
                self.isInteractionDisabled = false
                self.lastRotation = self.rotationAngle

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    completion?()
                }
                return
            }

            self.rotationAngle += currentVelocity
            currentVelocity *= friction
        }
    }

    func distributeColorsEvenly(_ colors: [Color], count: Int) -> [Color] {
        var result: [Color] = []
        var availableColors = colors.shuffled()

        for i in 0..<count {
            if availableColors.isEmpty {
                availableColors = colors.shuffled()
            }

            if i > 0, result.last == availableColors.first {
                availableColors.append(availableColors.removeFirst())
            }

            result.append(availableColors.removeFirst())
        }

        return result
    }
}

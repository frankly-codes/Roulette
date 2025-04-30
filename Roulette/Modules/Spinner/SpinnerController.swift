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
    let items: ItemsModel?
    let numSections: Int
    let colors: [Color]

    @Published var rotationAngle: Double = 0
    @Published var lastRotation: Double = 0
    @Published var angularVelocity: Double = 0
    @Published var isInteractionDisabled: Bool = false
    @Published var finalFontSize: CGFloat = 0

    private var decelerationTimer: Timer?
    lazy var colorDistribution: [Color] = distributeColorsEvenly(colors, count: numSections)

    init(size: CGFloat, items: ItemsModel? = nil, numSections: Int?, colors: [Color]) {
        self.size = size
        self.items = items ?? nil
        self.numSections = self.items?.count ?? numSections!
        self.colors = colors

        calculateFinalFontSize()
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
                item: items == nil ? nil : items?[index],
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
        guard !colors.isEmpty, count > 0 else { return [] }

        var result: [Color] = []
        var colorIndex = 0

        for i in 0..<count {
            let currentColor = colors[colorIndex % colors.count]

            if i > 0 && currentColor == result[i - 1] {
                colorIndex += 1
            }

            result.append(colors[colorIndex % colors.count])
            colorIndex += 1
        }

        if result.count > 1 {
            let firstColor = result.first
            let secondLastColor = result[result.count - 2]
            if result.last == firstColor || result.last == secondLastColor {
                if let replacement = colors.first(where: { $0 != firstColor && $0 != secondLastColor }) {
                    result[result.count - 1] = replacement
                }
            }
        }

        return result
    }

    private func calculateFinalFontSize() {
        let usableRadius = size * 0.25
        let segmentAngle = 360.0 / Double(numSections)
        let segmentArcLength = (segmentAngle / 360.0) * (2 * .pi * usableRadius)

        var baseFontSize = segmentArcLength * 0.6
        baseFontSize = min(baseFontSize, size * 0.07)
        baseFontSize = max(baseFontSize, size * 0.02)

        finalFontSize = baseFontSize
    }
}

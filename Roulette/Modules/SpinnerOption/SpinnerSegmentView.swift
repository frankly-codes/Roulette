//
//  SpinnerSegmentView.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import SwiftUI

struct SpinnerSegmentView: View {
    let option: SpinnerOptionModel
    @ObservedObject var viewModel: SpinnerController

    var body: some View {
        ZStack {
            Path { path in
                let center = CGPoint(x: option.size / 2, y: option.size / 2)
                let radius = option.size / 2

                path.move(to: center)
                path.addArc(center: center,
                            radius: radius,
                            startAngle: Angle(degrees: option.startAngle),
                            endAngle: Angle(degrees: option.endAngle),
                            clockwise: false)
                path.closeSubpath()
            }
            .fill(option.color)

            if let text = option.item?.text, !text.isEmpty {
                Text(text)
                    .font(.system(size: viewModel.finalFontSize, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .rotationEffect(.degrees((option.startAngle + option.endAngle) / 2))
                    .offset(
                        x: option.size * 0.25 * cos((option.startAngle + option.endAngle) / 2 * .pi / 180),
                        y: option.size * 0.25 * sin((option.startAngle + option.endAngle) / 2 * .pi / 180)
                    )
                    .frame(width: option.size * 0.35)
            }
        }
        .frame(width: option.size, height: option.size)
    }
}

//
//  SpinnerSegmentView.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import SwiftUI

struct SpinnerSegment: View {
    let option: SpinnerOptionModel
    var body: some View {
        ZStack {
            Path { path in
                let center = CGPoint(x: option.size / 2, y: option.size / 2)
                let radius = option.size / 2

                path.move(to: center)
                path.addArc(center: center, radius: radius, startAngle: Angle(degrees: option.startAngle), endAngle: Angle(degrees: option.endAngle), clockwise: false)
                path.closeSubpath()
            }
            .fill(option.color)

            if let text = option.text {
                Text(text)
                    .font(.system(size: option.size * 0.07, weight: .bold))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees((option.startAngle + option.endAngle) / 2))
                    .offset(x: option.size * 0.25 * cos((option.startAngle + option.endAngle) / 2 * .pi / 180),
                            y: option.size * 0.25 * sin((option.startAngle + option.endAngle) / 2 * .pi / 180))
            }
        }
        .frame(width: option.size, height: option.size)
    }
}

struct SpinningSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerSegment(option: SpinnerOptionModel(startAngle: 0, endAngle: 90, color: ComponentColors.background[0], text: "Hello world", size: 200))
    }
}


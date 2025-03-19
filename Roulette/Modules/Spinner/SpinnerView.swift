//
//  SpinnerView.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import SwiftUI

struct SpinnerView: View {
    @ObservedObject var viewModel: SpinnerController
    var selectedItem: Binding<String?>?

    var body: some View {
        ZStack {
            ForEach(viewModel.options) { option in
                SpinnerSegment(option: option)
            }
        }
        .rotationEffect(.degrees(viewModel.rotationAngle))
        .gesture(
            DragGesture()
                .onChanged { value in
                    guard !viewModel.isInteractionDisabled else { return }

                    let center = CGPoint(x: viewModel.size / 2, y: viewModel.size / 2)
                    let startLocation = value.startLocation
                    let currentLocation = value.location

                    let startAngle = atan2(startLocation.y - center.y, startLocation.x - center.x) * 180 / .pi
                    let currentAngle = atan2(currentLocation.y - center.y, currentLocation.x - center.x) * 180 / .pi

                    let deltaAngle = currentAngle - startAngle
                    viewModel.rotationAngle = viewModel.lastRotation + deltaAngle
                    viewModel.angularVelocity = deltaAngle * 5
                }
                .onEnded { _ in
                    viewModel.lastRotation = viewModel.rotationAngle
                    viewModel.isInteractionDisabled = true
                    viewModel.startDeceleration {
                        updateSelectedItem()
                    }
                }
        )
        .allowsHitTesting(!viewModel.isInteractionDisabled)
    }

    private func updateSelectedItem() {
        guard let selectedItem = selectedItem else { return }

        let segmentSize = 360 / Double(viewModel.options.count)
        let adjustedAngle = (viewModel.rotationAngle.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
        let correctedAngle = (360 - adjustedAngle + 90).truncatingRemainder(dividingBy: 360)
        let selectedIndex = Int(correctedAngle / segmentSize) % viewModel.options.count

        DispatchQueue.main.async {
            selectedItem.wrappedValue = viewModel.options[selectedIndex].text
        }
    }
}
struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView(
            viewModel: SpinnerController(
                size: 300,
                items: ["Hello", "GoodBye", "How are you?"],
                numSections: nil,
                colors: ComponentColors.rouletteBackground
            ),
            selectedItem: .constant(nil)
        )
    }
}

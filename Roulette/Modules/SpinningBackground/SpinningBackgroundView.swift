//
//  SpinningBackgroundView.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import SwiftUI

struct SpinningBackgroundView: View {
    @StateObject private var controller = SpinningBackgroundController()

    var body: some View {
        ZStack {
            ComponentColors.background
                .ignoresSafeArea()

            SpinnerView(
                viewModel: SpinnerController(
                    size: controller.dynamicSize,
                    items: nil,
                    numSections: controller.numSections,
                    colors: controller.colors
                )
            )
            .disabled(true)
            .rotationEffect(.degrees(controller.rotationAngle))
            .opacity(0.3)
            .animation(.default, value: controller.isAnimating)
            .onAppear {
                controller.startAnimation()
            }
            .ignoresSafeArea()

            VStack {
                Button(controller.isAnimating ? "Detener" : "Iniciar") {
                    controller.toggleAnimation()
                }
                .padding()
                .background(Color.black.opacity(0.5))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding()
            }
        }
    }
}

struct SpinningBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        SpinningBackgroundView()
    }
}

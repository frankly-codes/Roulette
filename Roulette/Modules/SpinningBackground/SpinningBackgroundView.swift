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
            RadialGradient(
                gradient: Gradient(colors: ComponentColors.background),
                center: .center,
                startRadius: controller.dynamicSize * 0.1,
                endRadius: controller.dynamicSize * 0.8
            )
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
            .blendMode(.overlay)
            .ignoresSafeArea()
            .animation(.default, value: controller.isAnimating)
            .onAppear {
                controller.startAnimation()
            }

            // Botón de prueba para iniciar/detener animación
            VStack {
                Button(controller.isAnimating ? "Detener" : "Iniciar") {
                    controller.toggleAnimation()
                }
                .padding()
                .background(Color.black.opacity(0.5))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding()
                .allowsHitTesting(true)
            }
        }
    }
}
struct SpinningBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        SpinningBackgroundView()
    }
}

//
//  SpinningBackgroundView.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import SwiftUI

import SwiftUI

struct SpinningBackgroundView: View {
    @State private var rotationAngle: Double = 0
    @State private var isAnimating: Bool = true

    // Calculamos el tamaño óptimo del spinner en función de la pantalla
    var screenSize: CGSize {
        UIScreen.main.bounds.size
    }
    var dynamicSize: CGFloat {
        max(screenSize.width, screenSize.height) * 1.2 // Asegura que cubra la pantalla
    }

    let opacity: Double = 0.1
    let numSections: Int = 40
    let colors: [Color] = ComponentColors.backgroundSegments

    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: ComponentColors.background), center: .center, startRadius: dynamicSize * 0.1, endRadius: dynamicSize * 0.8)
                .ignoresSafeArea()

            SpinnerView(
                size: dynamicSize, // 🔹 Usa tamaño dinámico
                opacity: opacity,
                items: nil,
                numSections: numSections,
                colors: colors, selectedItem: nil
            )
            .disabled(true)
            .rotationEffect(.degrees(rotationAngle))
            .blendMode(.overlay)
            .ignoresSafeArea()
            .animation(.default, value: isAnimating)
            .onAppear {
                startAnimation()
            }

            // Botón de prueba para iniciar/detener animación
            VStack {
                Button(isAnimating ? "Detener" : "Iniciar") {
                    isAnimating.toggle()
                    if isAnimating {
                        startAnimation()
                    } else {
                        rotationAngle = 0
                    }
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

    private func startAnimation() {
        guard isAnimating else { return }

        withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
    }
}

struct SpinningBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        SpinningBackgroundView()
    }
}

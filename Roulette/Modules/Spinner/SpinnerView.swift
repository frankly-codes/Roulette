//
//  SpinnerView.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import SwiftUI

struct SpinnerView: View {
    let size: CGFloat
    let opacity: Double
    let items: [String?]?
    let numSections: Int?
    let colors: [Color]
    var selectedItem: Binding<String?>? = nil // 🔹 Opcional para evitar errores

    @State private var rotationAngle: Double = 0
    @State private var lastRotation: Double = 0
    @State private var angularVelocity: Double = 0
    @State private var decelerationTimer: Timer?
    @State private var isInteractionDisabled: Bool = false

    var options: [SpinnerOptionModel] {
        let segmentCount = items?.count ?? numSections ?? 30
        let segmentSize = 360.0 / Double(segmentCount)

        return (0..<segmentCount).map { index in
            let start = segmentSize * Double(index) // 🔹 Asegura que el primer segmento comienza en 0°
            let end = start + segmentSize // 🔹 Mantiene la distribución uniforme

            return SpinnerOptionModel(
                startAngle: start,
                endAngle: end,
                color: colors[index % colors.count],
                text: items?[index],
                size: size
            )
        }
    }

    var body: some View {
        ZStack {
            ForEach(options) { option in
                SpinnerSegment(option: option)
            }
        }
        .rotationEffect(.degrees(rotationAngle))
        .gesture(
            DragGesture()
                .onChanged { value in
                    guard !isInteractionDisabled else { return }

                    let center = CGPoint(x: size / 2, y: size / 2)
                    let startLocation = value.startLocation
                    let currentLocation = value.location

                    let startAngle = atan2(startLocation.y - center.y, startLocation.x - center.x) * 180 / .pi
                    let currentAngle = atan2(currentLocation.y - center.y, currentLocation.x - center.x) * 180 / .pi

                    let deltaAngle = currentAngle - startAngle
                    rotationAngle = lastRotation + deltaAngle
                    angularVelocity = deltaAngle * 5
                }
                .onEnded { _ in
                    lastRotation = rotationAngle
                    isInteractionDisabled = true
                    applyInertia()
                }
        )
        .allowsHitTesting(!isInteractionDisabled)
    }

    private func updateSelectedItem() {
        guard let selectedItem = selectedItem else { return }

        let segmentSize = 360 / Double(options.count)

        // 🔹 Normalizamos el ángulo dentro del rango 0° a 360°
        var adjustedAngle = (rotationAngle.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)

        // 🔹 Corregimos el ángulo tomando como referencia el punto superior (90°)
        let correctedAngle = (360 - adjustedAngle + 90).truncatingRemainder(dividingBy: 360)

        // 🔹 Obtenemos el índice correcto
        let selectedIndex = Int(correctedAngle / segmentSize) % options.count

        // 🔹 Asignamos el valor seleccionado
        selectedItem.wrappedValue = options[selectedIndex].text

        print("DEBUG: adjustedAngle=\(adjustedAngle), correctedAngle=\(correctedAngle), selectedIndex=\(selectedIndex), segmentSize=\(segmentSize), rotationAngle=\(rotationAngle)")
    }
    
    private func applyInertia() {
        decelerationTimer?.invalidate()

        var currentVelocity = angularVelocity
        let friction: Double = 0.985

        decelerationTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { timer in
            if abs(currentVelocity) < 0.05 {
                timer.invalidate()
                isInteractionDisabled = false

                // 🔹 Dejamos que el giro termine naturalmente sin ajustes bruscos
                rotationAngle = (rotationAngle.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)

                updateSelectedItem()
                return
            }

            rotationAngle += currentVelocity
            currentVelocity *= friction
        }
    }
}

// 🔹 Vista Principal con Indicador y Texto Fijos
struct SpinnerContainerView: View {
    @State private var selectedItem: String? = nil // 🔹 Estado para el texto seleccionado

    var body: some View {
        VStack {
            SelectedItemView(selectedItem: selectedItem) // 🔹 Indicador de selección en la parte superior

            ZStack {
                SpinnerView(
                    size: 400,
                    opacity: 1.0,
                    items: ["Premio", "Nada", "Sorpresa", "Otra vez", "Bonus", "Sigue"],
                    numSections: nil,
                    colors: [ColorNames.rred, ColorNames.rblue, ColorNames.rorange],
                    selectedItem: $selectedItem // 🔹 Pasamos el binding válido
                )

                SelectionIndicator(size: 400) // 🔹 Indicador fijo en la parte superior
            }
        }
    }
}

// 🔹 Indicador de Ítem Seleccionado
struct SelectedItemView: View {
    let selectedItem: String?

    var body: some View {
        Text(selectedItem ?? "Gira la ruleta")
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }
}

// 🔹 Indicador Visual Fijo (Ya no rota con la ruleta)
struct SelectionIndicator: View {
    let size: CGFloat

    var body: some View {
        Rectangle()
            .frame(width: 4, height: 20)
            .foregroundColor(.red)
            .offset(y: size / 2 - 10) // 🔹 Mueve el indicador hacia la parte inferior
    }
}
struct SpinnerContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerContainerView()
    }
}

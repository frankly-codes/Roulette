//
//  MainView.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var controller = MainController()
    @StateObject private var spinnerController = SpinnerController(
        size: UIScreen.main.bounds.width * 0.8,
        items: ["Premio", "Nada", "Sorpresa", "Otra vez", "Bonus", "Sigue"],
        numSections: nil,
        colors: ComponentColors.rouletteBackground
    )

    var body: some View {
        ZStack {
            SpinningBackgroundView()
            VStack {
                SelectedItemView(selectedItem: $controller.selectedItem)

                ZStack {
                    SpinnerView(
                        viewModel: spinnerController,
                        selectedItem: $controller.selectedItem
                    )
                    .overlay(
                        Circle()
                            .stroke(ComponentColors.border, lineWidth: 5)
                    )
                    .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                        controller.updateScreenSize()
                    }

                    SelectionIndicator(size: controller.screenSize.width * 0.8)
                }
            }
        }
    }
}

struct SelectedItemView: View {
    @Binding var selectedItem: String?

    var body: some View {
        Text(selectedItem ?? Labels.SPIN_THE_WHEEL)
            .font(.title)
            .foregroundStyle(ComponentColors.label)
            .fontWeight(.bold)
            .padding()
    }
}

struct SelectionIndicator: View {
    let size: CGFloat

    var body: some View {
        Icons.MAPPIN
            .resizable()
            .scaledToFit()
            .rotationEffect(.degrees(180))
            .frame(width: 10, height: 40)
            .foregroundColor(ComponentColors.border)
            .offset(y: size / 2)
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//
//  SpinnerModuleView.swift
//  Roulette
//
//  Created by Frankly on 28/04/25.
//

import SwiftUI

struct SpinnerModuleView: View {
    @StateObject var controller: MainController

    var body: some View {
        ZStack {
            VStack {
                Text(controller.selectedItem ?? Labels.MainView.SPIN_THE_WHEEL)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(ComponentColors.label)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)

                ZStack {
                    SpinnerView(
                        viewModel: controller.spinnerController,
                        selectedItem: $controller.selectedItem
                    )
                    .overlay(
                        Circle()
                            .stroke(ComponentColors.border, lineWidth: 5)
                    )

                    // Indicador fijo
                    Icons.MAPPIN
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(180))
                        .frame(width: 10, height: 40)
                        .foregroundColor(ComponentColors.border)
                        .offset(y: (Constants.ScreenSize.screenSize.width * 0.8) / 2)
                }
                .frame(width: Constants.ScreenSize.screenSize.width * 0.8,
                       height: Constants.ScreenSize.screenSize.width * 0.8)
            }
        }
    }
}

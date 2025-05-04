//
//  SpinnerModuleView.swift
//  Roulette
//
//  Created by Frankly on 28/04/25.
//

import SwiftUI
import ConfettiSwiftUI

struct SpinnerModuleView: View {
    @StateObject var controller: MainController
    @State private var trigger: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Text(controller.selectedItem ?? Labels.MainView.SPIN_THE_WHEEL)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(ComponentColors.label)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .onChange(of: controller.selectedItem){
                        controller.showResult = true
                    }

                ZStack {
                    SpinnerView(
                        viewModel: controller.spinnerController,
                        selectedItem: $controller.selectedItem
                    )
                    .overlay(
                        Circle()
                            .stroke(ComponentColors.border, lineWidth: 5)
                    )

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
            
            if controller.showResult {
                SelectedItemPopupView(controller: controller)
                    .confettiCannon(
                        trigger: $trigger,
                        num: 100,
                        colors: ComponentColors.rouletteBackground,
                        confettiSize: 20,
                        radius: 400
                    )
                    .onAppear{
                        //Trigger dosen't care about the value, just needs an update to its value to trigger the animation
                        trigger.toggle()                        
                    }
                    .onDisappear{
                        controller.showResult = false
                    }
            }
        }
    }
}

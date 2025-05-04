//
//  MainView.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var controller = MainController()
    
    var body: some View {
        ZStack {
            VStack {
                SettingsButtonView(controller: controller)
                Spacer()
                TitleModuleView(controller: controller)
                SpinnerModuleView(controller: controller)
                Spacer()
                EditButtonModuleView(controller: controller)
            }
            .blur(radius: controller.showEdit ? 9 : 0)
            .ignoresSafeArea()
            
            if controller.showEdit {
                ItemsView(mainController: controller, itemsController: controller.itemsController)
            }
        }
        .fullScreenCover(isPresented: $controller.showSettings) {
            SettingsView(controller: SettingsController())
        }
        .background(
            SpinningBackgroundView()
                .scaleEffect(2.0)
                .ignoresSafeArea()
                .blur(radius: controller.showEdit ? 9 : 0)
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

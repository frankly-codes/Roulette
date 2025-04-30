//
//  MainView.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import SwiftUI

import SwiftUI

struct MainView: View {
    @StateObject var controller = MainController()

    var body: some View {
        ZStack {
            VStack {
                SettingsButtonView(controller: controller)
                Spacer()
                TitleModuleView(controller: controller)
                SpinnerModuleView(controller: controller)
                EditButtonModuleView(controller: controller)
                Spacer()
            }
        }
        .fullScreenCover(isPresented: Binder.bind(controller, \.showSettings)) {
            SettingsView(controller: SettingsController())
        }
        .sheet(isPresented: Binder.bind(controller, \.showEdit)) {
            ItemsView(controller: ItemsController(items: controller.spinnerController.items!))
        }
        .background(
            SpinningBackgroundView()
                .scaleEffect(2.0)
                .ignoresSafeArea()
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

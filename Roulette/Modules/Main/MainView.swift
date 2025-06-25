//
//  MainView.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var controller = MainController()
    @State private var showLaunchScreen = true
    @State private var showAppContent = false
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Images.ROULETTE
                            .resizable()
                            .scaledToFit()
                            .frame(width: Constants.ScreenSize.screenSize.width * 0.3)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        SettingsButtonView(controller: controller)
                    }
                }
                .padding(.top, 60)
                
                Spacer()
                TitleModuleView(controller: controller)
                SpinnerModuleView(controller: controller)
                Spacer()
                EditButtonModuleView(controller: controller)
                    .padding()
            }
            .blur(radius: controller.showEdit ? 9 : 0)
            .ignoresSafeArea()
            .opacity(showAppContent ? 1 : 0)
            .scaleEffect(showAppContent ? 1 : 0.5)
            .animation(.easeOut(duration: 0.6), value: showAppContent)
            
            if controller.showEdit {
                ItemsView(mainController: controller, itemsController: controller.itemsController)
                    .padding()
            }
            
            if showLaunchScreen {
                LaunchScreenView(
                    onStartExit: {
                        withAnimation {
                            showAppContent = true
                        }
                    },
                    onFinish: {
                        withAnimation {
                            showLaunchScreen = false
                        }
                    }
                )
                .transition(.opacity)
                .zIndex(1)
            }
        }
        .fullScreenCover(isPresented: $controller.showSettings) {
            SettingsView(controller: SettingsController())
        }
        .background(
            SpinningBackgroundView()
                .scaleEffect(2.0)
                .ignoresSafeArea()
                .blur(radius: (controller.showEdit || controller.showResult) ? 9 : 0)
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

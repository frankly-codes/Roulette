//
//  MainView.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var controller = MainController()
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        controller.showSettings = true
                    }){
                        Icons.SETTINGS
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(ComponentColors.button)
                            .frame(width: 40)
                            .padding()
                    }
                    .padding(.top)
                    
                }
                Spacer()
            }
            VStack{
                SelectedItemView(selectedItem: $controller.selectedItem)
                
                ZStack {
                    SpinnerView(
                        viewModel: controller.spinnerController,
                        selectedItem: $controller.selectedItem
                    )
                    .overlay(
                        Circle()
                            .stroke(ComponentColors.border, lineWidth: 5)
                    )
                    
                    SelectionIndicator(size: Constants.ScreenSize.screenSize.width * 0.8)
                }
            }
            VStack{
                EditModule(controller: controller, size: Constants.ScreenSize.screenSize.height * 0.8)
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

struct SelectedItemView: View {
    @Binding var selectedItem: String?

    var body: some View {
        Text(selectedItem ?? Labels.MainView.SPIN_THE_WHEEL)
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

struct EditModule: View {
    @StateObject var controller: MainController
    let size: CGFloat

    var body: some View {
        HStack{
            Button(action: {
                controller.showEdit = true
            }){
                Icons.EDIT_BUTTON
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(180))
                    .frame(width: 10, height: 40)
                    .foregroundColor(ComponentColors.border)
                    .offset(y: size / 2)
            }
        }
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

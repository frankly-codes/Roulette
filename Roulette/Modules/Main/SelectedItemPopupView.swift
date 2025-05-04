//
//  SelectedItemPopupView.swift
//  Roulette
//
//  Created by Frankly on 04/05/25.
//

import SwiftUI

struct SelectedItemPopupView: View {
    @ObservedObject var controller: MainController
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .stroke(ComponentColors.stroke, lineWidth: 4)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(ComponentColors.background))
                )
            VStack{
                
                Text(controller.selectedItem!)
                    .font(.title)
                    .bold()
                    .foregroundStyle(ComponentColors.label)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: {
                    controller.showResult = false
                }) {
                    Text(Labels.ItemsView.SKIP)
                        .bold()
                        .padding()
                        .background(ComponentColors.button)
                        .foregroundColor(ComponentColors.label_pink)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    //TODO: RESTORE itemsController.deleteItems
                    controller.showResult = false
                }) {
                    Text(Labels.ItemsView.DELETE_ONE)
                        .bold()
                        .padding()
                        .background(ComponentColors.buttonAccent)
                        .foregroundColor(ComponentColors.label)
                        .cornerRadius(10)
                }
            }
            .shadow(radius: 3)
        }
    }
}

#Preview {
    SelectedItemPopupView(controller: MainController())
}


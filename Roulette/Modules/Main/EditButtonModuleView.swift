//
//  EditButtonModuleView.swift
//  Roulette
//
//  Created by Frankly on 28/04/25.
//

import SwiftUI

struct EditButtonModuleView: View {
    @StateObject var controller: MainController

    var body: some View {
        HStack{
            Spacer()
            
            Button(action: {
                controller.showEdit = true
            }) {
                Icons.EDIT_BUTTON
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
                    .foregroundColor(ComponentColors.border)
                    .padding(.top, 20)
                    .shadow(radius: 3)
            }
        }
    }
}

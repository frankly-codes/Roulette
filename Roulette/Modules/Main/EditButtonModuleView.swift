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
        Button(action: {
            controller.showEdit = true
        }) {
            Icons.EDIT_BUTTON
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(180))
                .frame(width: 30, height: 30)
                .foregroundColor(ComponentColors.border)
                .padding(.top, 20)
        }
    }
}

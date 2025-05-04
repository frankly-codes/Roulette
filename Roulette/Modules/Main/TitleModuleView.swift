//
//  TitleModuleView.swift
//  Roulette
//
//  Created by Frankly on 28/04/25.
//

import SwiftUI

struct TitleModuleView: View {
    @ObservedObject var controller: MainController

    var body: some View {
        HStack{
            Text(controller.rouletteName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(ComponentColors.label)
            Button(action: {
                controller.showEdit = true
            }) {
                Icons.PENCIL
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(ComponentColors.label.opacity(0.5))
                    .frame(width: 20)
            }
        }
        .padding(.top, 40)
    }
}

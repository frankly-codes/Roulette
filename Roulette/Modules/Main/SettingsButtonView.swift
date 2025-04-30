//
//  SettingsButtonView.swift
//  Roulette
//
//  Created by Frankly on 28/04/25.
//

import SwiftUI

struct SettingsButtonView: View {
    @ObservedObject var controller: MainController

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                controller.showSettings = true
            }) {
                Icons.SETTINGS
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(ComponentColors.button)
                    .frame(width: 40)
                    .padding()
            }
            .padding(.top)
        }
    }
}

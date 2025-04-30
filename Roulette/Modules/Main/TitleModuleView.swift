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
        Text(controller.rouletteName ?? Labels.MainView.GENERIC_WHEEL_TITLE)
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(ComponentColors.label)
            .padding(.top, 40)
    }
}

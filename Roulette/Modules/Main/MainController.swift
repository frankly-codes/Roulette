//
//  MainController.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import Foundation
import SwiftUI

class MainController: ObservableObject {
    @Published var selectedItem: String?
    @Published var rouletteName: String
    @Published var showSettings = false
    @Published var showEdit = false
    @Published var showResult = false
    @Published var itemsController: ItemsController
    @Published var spinnerController: SpinnerController
    

    init() {
        //TODO: Implement initialization for all the controllers. Find a way to share Binding values between multiple controllers
        selectedItem = nil
        rouletteName = Labels.MainView.GENERIC_WHEEL_TITLE
        itemsController = ItemsController(items: Constants.genericItems.examples, rouletteName: Labels.MainView.GENERIC_WHEEL_TITLE)
        spinnerController = SpinnerController(
            size: UIScreen.main.bounds.width * 0.8,
            items: ItemsController(items: Constants.genericItems.examples, rouletteName: Labels.MainView.GENERIC_WHEEL_TITLE),
            numSections: nil,
            colors: ComponentColors.rouletteBackground
        )
    }

    func updateSelectedItem(newItem: String) {
        selectedItem = newItem
    }
    
}

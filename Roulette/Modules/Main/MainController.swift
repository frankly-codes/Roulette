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
    @Published var rouletteName: String?
    @Published var showSettings = false
    @Published var showEdit = false
    @Published var spinnerController: SpinnerController
    

    init() {
        //TODO: Implement initialization for all the controllers
        self.selectedItem = nil
        self.spinnerController = SpinnerController(
            size: UIScreen.main.bounds.width * 0.8,
            items: Constants.genericItems.examples, //TODO: Replace for validation between example or persistent data
            numSections: nil,
            colors: ComponentColors.rouletteBackground
        )
    }

    func updateSelectedItem(newItem: String) {
        selectedItem = newItem
    }
    
}

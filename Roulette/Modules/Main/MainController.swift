//
//  MainController.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import Foundation
import SwiftUI

class MainController: ObservableObject {
    @Published var screenSize: CGSize
    @Published var selectedItem: String?

    init() {
        self.screenSize = UIScreen.main.bounds.size
        self.selectedItem = nil
    }

    func updateScreenSize() {
        screenSize = UIScreen.main.bounds.size
    }

    func updateSelectedItem(newItem: String) {
        selectedItem = newItem
    }
}

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
   

    init() {
        self.selectedItem = nil
    }

    func updateSelectedItem(newItem: String) {
        selectedItem = newItem
    }
}

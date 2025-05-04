//
//  ItemsController.swift
//  Roulette
//
//  Created by Frankly on 26/04/25.
//

import Foundation
import SwiftUI

class ItemsController: ObservableObject{
    @Published var items: ItemsModel
    @Published var rouletteName: String
    
    init(items: ItemsModel, rouletteName: String) {
        self.items = items
        self.rouletteName = rouletteName
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func deleteItems() {
        items.removeAll()
    }
    
    func addItem() {
        items.append(Item(text: ""))
    }
    
    func saveItems() {
        print("Saving Items: \(items.map { $0.text })")
    }
    
    var isSaveDisabled: Bool {
        var isSaveDisabled: Bool {
            let hasEmptyItem = items.contains { $0.text.trimmingCharacters(in: .whitespaces).isEmpty }
            let isItemsEmpty = items.isEmpty
            let isTitleEmpty = rouletteName.trimmingCharacters(in: .whitespaces).isEmpty

            return hasEmptyItem || isItemsEmpty || isTitleEmpty
        }
        return isSaveDisabled
    }
}

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
    
    init(items: ItemsModel) {
        self.items = items
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func addItem() {
        items.append(Item(text: ""))
    }
    
    func saveItems() {
        // Aquí puedes hacer el guardado real
        print("Saving Items: \(items.map { $0.text })")
    }
    
    var isSaveDisabled: Bool {
        items.contains { $0.text.trimmingCharacters(in: .whitespaces).isEmpty }
    }
    
    func binding(for index: Int) -> Binding<String> {
        Binding(
            get: { self.items[index].text },
            set: { self.items[index].text = $0 }
        )
    }
}

//
//  ItemsView.swift
//  Roulette
//
//  Created by Frankly on 26/04/25.
//

import SwiftUI

struct ItemsView: View {
    @Environment(\.editMode) private var editMode
    @State var controller: ItemsController
    var body: some View {
        VStack {
            List {
                ForEach(0..<controller.items.count, id: \.self) { index in
                    TextField("Untitled Item", text: controller.binding(for: index))
                        .textFieldStyle(.roundedBorder)
                }
                .onMove(perform: controller.moveItem)
                .onDelete(perform: controller.deleteItems)
                
                Button(action: controller.addItem) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add New Item")
                    }
                    .padding(.vertical, 8)
                }
            }
            
            Button(action: controller.saveItems) {
                Text("Save Items")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(controller.isSaveDisabled ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
            .disabled(controller.isSaveDisabled)
        }
        .onAppear {
            editMode?.wrappedValue = .active
        }
        .navigationTitle("Edit Items")
    }
}

#Preview {
    ItemsView(controller: ItemsController(items: ItemsModel(
        [Item(text: "Hello"),
        Item(text: "Bye"),
         Item(text: "Greetings")
        ])))
}

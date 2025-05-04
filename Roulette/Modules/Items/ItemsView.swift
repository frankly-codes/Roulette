//
//  ItemsView.swift
//  Roulette
//
//  Created by Frankly on 26/04/25.
//

import SwiftUI

struct ItemsView: View {
    @Environment(\.editMode) private var editMode
    @ObservedObject var mainController: MainController
    @ObservedObject var itemsController: ItemsController
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .stroke(ComponentColors.stroke, lineWidth: 4)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(ComponentColors.background))
                )
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        mainController.showEdit = false
                    }) {
                        Icons.XMARK
                            .foregroundColor(ComponentColors.button)
                    }
                    .padding()
                }
                
                Text(Labels.ItemsView.TITLE)
                    .font(.title)
                    .bold()
                    .foregroundStyle(ComponentColors.label)
                
                TextField("Untitled roulette", text: $itemsController.rouletteName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                List {
                    ForEach(0..<itemsController.items.count, id: \.self) { index in
                        TextField(Labels.ItemsView.UNTITLED, text: $itemsController.items[index].text)
                            .textFieldStyle(.roundedBorder)
                            .ignoresSafeArea()
                    }
                    .onMove(perform: itemsController.moveItem)
                    .onDelete(perform: itemsController.deleteItems)
                    .onAppear {
                        editMode?.wrappedValue = .active
                    }
                    
                    Button(action: itemsController.addItem) {
                        HStack {
                            Icons.PLUS_CIRCLE
                            Text(Labels.ItemsView.ADD)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .scrollContentBackground(.hidden)
                
                Button(action: {
                    //TODO: RESTORE controller.itemsController.saveItems
                    mainController.showEdit = false
                }) {
                    Text(Labels.ItemsView.SAVE)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(itemsController.isSaveDisabled ? ComponentColors.background : ComponentColors.button)
                        .foregroundColor(ComponentColors.label_pink)
                        .cornerRadius(10)
                        .padding()
                }
                .disabled(itemsController.isSaveDisabled)
                
                Button(action: itemsController.deleteItems) {
                    Text(Labels.ItemsView.DELETE)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(ComponentColors.buttonAccent)
                        .foregroundColor(ComponentColors.label)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .shadow(radius: 3)
        }
    }
}

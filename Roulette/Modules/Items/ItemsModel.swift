//
//  ItemsModel.swift
//  Roulette
//
//  Created by Frankly on 26/04/25.
//

import Foundation

typealias ItemsModel = [Item]
struct Item: Identifiable{
    let id = UUID()
    var text: String
}

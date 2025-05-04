//
//  SpinnerOptionModel.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import Foundation
import SwiftUI

struct SpinnerOptionModel: Identifiable {
    let id = UUID()
    let startAngle: Double
    let endAngle: Double
    let color: Color
    let item: Item?
    let size: CGFloat
}

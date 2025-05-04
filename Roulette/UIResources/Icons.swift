//
//  Icons.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import Foundation
import SwiftUI

struct IconNames {
    static let MAPPIN = "mappin"
    static let SETTINGS = "line.3.horizontal"
    static let XMARK = "xmark"
    static let GEAR_CIRCLE = "gear.circle.fill"
    static let PLUS_CIRCLE = "plus.circle.fill"
    static let PENCIL = "pencil"
}

struct Icons {
    static let MAPPIN = Image(systemName: IconNames.MAPPIN)
    static let SETTINGS = Image(systemName: IconNames.SETTINGS)
    static let XMARK = Image(systemName: IconNames.XMARK)
    static let EDIT_BUTTON = Image( systemName: IconNames.GEAR_CIRCLE)
    static let PLUS_CIRCLE = Image( systemName: IconNames.PLUS_CIRCLE)
    static let PENCIL = Image( systemName: IconNames.PENCIL)
}

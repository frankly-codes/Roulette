//
//  Colors.swift
//  Roulette
//
//  Created by Frankly on 18/03/25.
//

import Foundation

import SwiftUI

struct ColorNames {
    static let rblack = Color("RBlack")
    static let rblue = Color("RBlue")
    static let rorange = Color("ROrange")
    static let rpink = Color("RPink")
    static let rred = Color("RRed")
    static let rwhite = Color("RWhite")
    static let ryellow = Color("RYellow")
}

struct ComponentColors {
    static let label = ColorNames.rwhite
    static let label_pink = ColorNames.rpink
    static let border = ColorNames.rwhite
    static let button = ColorNames.rwhite
    static let buttonAccent = ColorNames.rred
    static let stroke = ColorNames.rwhite
    static let toggle = ColorNames.rpink
    static let background = ColorNames.rpink
    static let backgroundSegments = [ColorNames.rwhite.opacity(0.3), ColorNames.rwhite.opacity(0)]
    static let rouletteBackground = [ColorNames.rblue, ColorNames.rorange, ColorNames.rpink, ColorNames.rred,ColorNames.ryellow]
}

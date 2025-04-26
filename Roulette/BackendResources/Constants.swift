//
//  Constants.swift
//  Roulette
//
//  Created by Frankly on 20/03/25.
//

import Foundation
import UIKit

public struct Constants {
    struct ColorMode {
        enum Theme: String, CaseIterable, Identifiable {
            case light, dark, system
            
            var id: Self { self }
            
            var displayName: String {
                switch self {
                case .light: return "Light"
                case .dark: return "Dark"
                case .system: return "Same as system"
                }
            }
        }
    }
    struct ScreenSize{
        static let screenSize = UIScreen.main.bounds.size

    }
}

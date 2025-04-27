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
    
    struct genericItems{
        //Items for first time running or whenever the persistent data is empty
        static let examples: ItemsModel = [
                Item(text: "Dance like no one’s watching"),
                Item(text: "Sing your favorite song out loud"),
                Item(text: "Do 10 jumping jacks"),
                Item(text: "Pretend you’re a superhero for 30 seconds"),
                Item(text: "Tell a silly joke"),
                Item(text: "Take a dramatic slow-motion walk"),
                Item(text: "Invent a handshake with the nearest person"),
                Item(text: "Balance something on your head for 10 seconds"),
                Item(text: "Do your best animal impression"),
                Item(text: "Give a compliment to yourself")
            ]
    }
}

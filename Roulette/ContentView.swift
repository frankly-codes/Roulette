//
//  ContentView.swift
//  Roulette
//
//  Created by Frankly on 14/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            SpinningBackgroundView()
            VStack {
                SpinnerContainerView()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

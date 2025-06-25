//
//  LaunchScreenView.swift
//  Roulette
//
//  Created by Frankly on 24/06/25.
//

import SwiftUI

struct LaunchScreenView: View {
    var onStartExit: (() -> Void)? = nil
    var onFinish: (() -> Void)? = nil

    @State private var logoScale: CGFloat = 0.6
    @State private var rotationAngle: Double = 0
    @State private var shouldExplode = false
    @State private var blurRadius: CGFloat = 0
    @State private var logoOpacity: Double = 1.0
    @State private var isHidden = false

    var dynamicSize: CGFloat {
        max(Constants.ScreenSize.screenSize.width, Constants.ScreenSize.screenSize.height) * 1.2
    }

    let colors: [Color] = ComponentColors.backgroundSegments

    var body: some View {
        ZStack {
            if !isHidden {
                Images.R
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.ScreenSize.screenSize.width * 0.7)
                    .scaleEffect(shouldExplode ? 10.0 : logoScale)
                    .blur(radius: blurRadius)
                    .opacity(logoOpacity)
            }
        }
        .onAppear {
            rotationAngle = 360

            withAnimation(.easeOut(duration: 0.6)) {
                logoScale = 1.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.interpolatingSpring(stiffness: 120, damping: 8)) {
                    logoScale = 1.1
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    onStartExit?()

                    withAnimation(.easeIn(duration: 1)) {
                        shouldExplode = true
                        blurRadius = 20
                        logoOpacity = 0.0
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        isHidden = true
                        onFinish?()
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}

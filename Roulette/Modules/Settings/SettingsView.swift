//
//  SettingsView.swift
//  Roulette
//
//  Created by Frankly on 19/03/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var controller: SettingsController
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack {
            ComponentColors.background
                .ignoresSafeArea()
            
            VStack {
                HStack{
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Icons.XMARK    
                            .foregroundColor(ComponentColors.button)
                    }
                    .padding()
                }
                Form {
                    Section(header: 
                                Text(Labels.Settings.GENERAL)
                        .foregroundStyle(ComponentColors.label)
                    ) {
                        Toggle(Labels.Settings.SOUND, isOn: $controller.sound)
                            .tint(ComponentColors.toggle)
                            .foregroundColor(ComponentColors.label_pink)
                        Toggle(Labels.Settings.VIBRATION, isOn: $controller.hapticFeedback)
                            .tint(ComponentColors.toggle)
                            .foregroundColor(ComponentColors.label_pink)
                        
                    }
                    
                    Section(header: 
                                Text(Labels.Settings.VIBRATION)
                        .foregroundStyle(ComponentColors.label)
                    ) {
                        Picker(Labels.Settings.THEME, selection: $controller.selectedMode) {
                            ForEach(Constants.ColorMode.Theme.allCases, id: \.self) { theme in
                                Text(theme.displayName).tag(theme)
                            }
                        }
                        .tint(ComponentColors.toggle.opacity(0.8))
                        .foregroundColor(ComponentColors.label_pink)
                        
                        
                    }
                    
                    Section(header: 
                                Text(Labels.Settings.ANIMATION_SPEED)
                        .foregroundStyle(ComponentColors.label)
                    ) {
                        VStack {
                            Slider(value: $controller.animationDuration, in: 1...10, step: 1)
                            Text("\(Labels.Settings.SPEED)  \(Int(controller.animationDuration))")
                                .font(.caption)
                                .foregroundColor(ComponentColors.label_pink)
                            
                        }
                    }
                    
                    Section {
                        Button(Labels.Settings.RESET_SETTINGS, role: .destructive) {
                            controller.resetSettings()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .listRowBackground(ComponentColors.button)
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    SettingsView(controller: .init())
}

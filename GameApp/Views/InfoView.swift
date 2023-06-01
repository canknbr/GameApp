//
//  InfoView.swift
//  GameApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoView()
            Spacer()
            Form {
                Section {
                    FormRowView(title: "Application", desc: "Slot Machine")
                    FormRowView(title: "Platforms", desc: "iPhone, iPad, Mac")
                    FormRowView(title: "Developer", desc: "Can Kanbur")
                    FormRowView(title: "Designer", desc: "Robert Petras")
                    FormRowView(title: "Music", desc: "Dan Lebowitz")
                    FormRowView(title: "Version", desc: "1.0.0")
                } header: {
                    Text("About the application")
                }
            }
            .font(.system(.body, design: .rounded))
        }
        .padding(.top, 40)
        .overlay(
            Button(action: {
                audioPlayer?.stop()
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .tint(.accentColor)
                    .frame(width: 40, height: 40)
                    
            }
            )

            .padding(.trailing, 20), alignment: .topTrailing
        )
        .onAppear {
            playSound(soundName: "background-music", soundType: "mp3")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

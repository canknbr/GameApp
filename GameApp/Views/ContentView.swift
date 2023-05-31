//
//  ContentView.swift
//  GameApp
//
//  Created by Can Kanbur on 31.05.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 5) {
                LogoView()
                Spacer()
            }
            .overlay(
                Button(action: {
                    print("reser")
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")

                })
                .modifier(ButtonModifier())
                .padding(.leading,-10)
                .padding(.top,-5)
                , alignment: .topLeading
            )
            .overlay(
                Button(action: {
                    print("reser")
                }, label: {
                    Image(systemName: "info.circle")

                })
                .modifier(ButtonModifier())
                .padding(.trailing,-10)
                .padding(.top,-5)
                , alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  Modifiers.swift
//  GameApp
//
//  Created by Can Kanbur on 31.05.2023.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: Color("ColorTransparentBlack"), radius: 10, x: 0, y: 3)
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.title).tint(.white)
    }
}

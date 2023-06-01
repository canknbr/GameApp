//
//  Extensions.swift
//  GameApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import SwiftUI

extension Text {
    func scoreLabelStyle() -> Text {
        foregroundColor(.white)
            .bold()
            .font(.system(size: 10, design: .rounded))
    }
    func scoreNumberStyle() -> Text {
        self.foregroundColor(.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}



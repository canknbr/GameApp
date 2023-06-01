//
//  FormRowView.swift
//  GameApp
//
//  Created by Can Kanbur on 1.06.2023.
//

import SwiftUI


struct FormRowView: View {
    let title : String
    let desc : String
    var body: some View {
        HStack{
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(desc)
        }
    }
}

struct FormRowView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowView(title: "", desc: "")
    }
}

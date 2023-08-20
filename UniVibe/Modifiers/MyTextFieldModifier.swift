//
//  MyTextFieldModifier.swift
//  Gharrid
//
//  Created by Taha Al on 8/13/23.
//

import SwiftUI

struct MyTextFieldModifier: ViewModifier {
    var horizontalPadding: CGFloat = 24
    
    func body(content: Content) -> some View {
        content.font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, horizontalPadding)
            
    }
}

struct MyTextFieldModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("some text").modifier(MyTextFieldModifier())
    }
}

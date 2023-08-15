//
//  MyTimeStringModifier.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct MyTimeStringModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.subheadline).foregroundColor(.green)
            
    }
    
}

struct MyTimeStringModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("this is time").modifier(MyTimeStringModifier())
    }
}

//
//  MyNavigationLinkModifier.swift
//  Gharrid
//
//  Created by Taha Al on 8/13/23.
//

import SwiftUI

struct MyNavigationLinkModifier3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)// removes the top padding
            .navigationTitle("")
            .tint(.black)
            .disabled(true)
            .hidden()
    }
}

struct MyNavigationLinkModifier_Previews: PreviewProvider {
    static var previews: some View {
        //MyNavigationLinkModifier()
        Text("")
    }
}

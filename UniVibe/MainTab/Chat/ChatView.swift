//
//  ChatView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var currentUserViewModel = CurrentUserViewModel.shared

    var body: some View {
        
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.linearGradientBackground()
        

    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

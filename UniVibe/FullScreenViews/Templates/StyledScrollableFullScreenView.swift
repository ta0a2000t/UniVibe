//
//  StyledScrollableFullScreenView.swift
//  UniVibe
//
//  Created by Taha Al on 8/22/23.
//

import SwiftUI

struct StyledScrollableFullScreenView<Content: View>: View {
    var scrollViewContent: Content
    let title: String
    
    @Environment(\.colorScheme) private var colorScheme

    
    var body: some View {
        
        ZStack(alignment: .top){
            
            
            ScrollView {
                VStack {
                    
                    
                    scrollViewContent
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    Spacer()
                }.padding(.top, 70)
                
            }
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .shadow(radius: 2)
            
        }.linearGradientBackground()
        
    }
    
}

struct StyledScrollableFullScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        StyledScrollableFullScreenView(scrollViewContent: EventListView(events: Event.MOCK), title: "Feed")
    }
}

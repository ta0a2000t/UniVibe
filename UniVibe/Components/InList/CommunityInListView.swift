//
//  CommunityInListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct CommunityInListView: View {
    let membersCount : Int
    let communityName : String
    
    var body: some View {
        HStack {
            Image("zuckerberg").resizable().scaledToFit().frame(width: 55, height: 55).clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading) {
                Text(communityName).font(.headline).bold()
                Text("\(membersCount) members")
            }
            Spacer()
            
        }.padding(.horizontal, 7)
            .frame(width: .infinity, height: 65)
            .background(Color(.gray).opacity(0.85))
            .cornerRadius(10)
    }
}

struct CommunityInListView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityInListView(membersCount: 197, communityName: "LEVELS Game Nights")
    }
}

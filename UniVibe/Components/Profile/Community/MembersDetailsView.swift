//
//  MembersDetailsView.swift
//  UniVibe
//
//  Created by Taha Al on 8/16/23.
//

import SwiftUI

struct MembersDetailsView: View {
    let membersCount: Int
    
    var body: some View {
        HStack {
            Image(systemName: "person.3").resizable().scaledToFit().frame(width: 25)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(membersCount)").font(.callout).bold()
                    Text("Members").font(.callout)

                }
            }.padding(.leading)
            Spacer()
            Image(systemName: "chevron.right")
            
        }.padding(10).padding(.trailing, 8).overlay(RoundedRectangle(cornerRadius: 20).foregroundColor(.orange).opacity(0.2))
        
    }
}

struct MembersDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MembersDetailsView(membersCount: 10)
    }
}

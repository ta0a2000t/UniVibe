//
//  EventLocDetailsView.swift
//  UniVibe
//
//  Created by Taha Al on 8/16/23.
//

import SwiftUI

struct EventLocDetailsView: View {
    let locationName: String
    let locationDescription: String
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse").resizable().scaledToFit().frame(width: 25)
            
            VStack(alignment: .leading) {
                Text(locationName).font(.callout)
                Text(locationDescription).font(.footnote)
            }.padding(.leading)
            Spacer()
            Image(systemName: "link")
            
        }.padding(10).padding(.trailing, 8).overlay(RoundedRectangle(cornerRadius: 20).foregroundColor(.blue).opacity(0.2))
        
    }
}

struct EventLocDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventLocDetailsView(locationName: "Stamp Student Union", locationDescription: "2nd floor next to bathrooms.")
    }
}

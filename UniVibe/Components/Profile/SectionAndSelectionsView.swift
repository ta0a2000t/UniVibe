//
//  SectionAndSelectionsView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct SectionAndSelectionsView: View {
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
            // TODO: length of rows = len(selections) // 3
    let title : String
    
    @State var selections: [String]

    var body: some View {
        
        VStack(alignment: .leading){
            Text("\(title) (\(selections.count))").font(.title2).bold()
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows) {
                    ForEach(selections, id: \.self) { selectedItem in
                        
                        
                        Text(selectedItem).font(.callout).padding(6).overlay(RoundedRectangle(cornerRadius: 20).foregroundColor(.pink).opacity(0.2))
                        
                        
                    }
                }
                
            }.frame(height: 75)
            
        }.padding(.horizontal)
    }
}

struct SectionAndSelectionsView_Previews: PreviewProvider {
    static var previews: some View {
        SectionAndSelectionsView(title: "Interests", selections:
                                    ["Out1ddoor", "Painti44ng","Outd32door", "Paint4ging", "Swimming"])
    }
}

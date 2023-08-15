//
//  EventProfileView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct EventProfileView: View {
    let event: Event
    @Environment (\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Text("id: \(event.id)")
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(event.title)
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left").resizable()
                }
                
            }
            
        }
    }
}

struct EventProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EventProfileView(event: Event.MOCK[0])
    }
}

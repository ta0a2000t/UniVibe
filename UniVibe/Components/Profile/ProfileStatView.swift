//
//  ProfileStatView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct ProfileStatView: View {
    @State var value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)").font(.subheadline).fontWeight(.semibold)
            Text(title)
                .font(.footnote)
        }
    }
}

struct ProfileStatView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileStatView(value: 23, title: "followers")
    }
}

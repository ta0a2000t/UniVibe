//
//  BlankEventPFPView.swift
//  UniVibe
//
//  Created by Taha Al on 8/27/23.
//

import SwiftUI

struct BlankEventPFPView: View {
    var body: some View {
        Image(systemName:"figure.socialdance").resizable().padding().background(.gray.opacity(0.5))
    }
}

struct BlankEventPFPView_Previews: PreviewProvider {
    static var previews: some View {
        BlankEventPFPView()
    }
}

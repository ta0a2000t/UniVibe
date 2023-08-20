//
//  LogoOnTopMiddleView.swift
//  UniVibe
//
//  Created by Taha Al on 8/20/23.
//

import SwiftUI

struct LogoOnTopMiddleView: View {
    var body: some View {
        Image("univibe_logo").resizable().scaledToFit().frame(height: 35)
    }
}

struct LogoOnTopMiddleView_Previews: PreviewProvider {
    static var previews: some View {
        LogoOnTopMiddleView()
    }
}

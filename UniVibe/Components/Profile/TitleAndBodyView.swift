//
//  AboutView.swift
//  UniVibe
//
//  Created by Taha Al on 8/16/23.
//

import SwiftUI

struct TitleAndBodyView: View {
    let title: String
    let textBody: String
    var body: some View {
        VStack(alignment:.leading){
            Text(title).font(.title2).bold().padding(.bottom, 1)
            Text(textBody).lineLimit(nil)
        }
    }
}

struct TitleAndBodyViewPreviews: PreviewProvider {
    static var previews: some View {
        TitleAndBodyView(title: "About", textBody: "Aafdsjifjds iofjadsrori rfjdsr oij re r reefodisajee e e ee  foiadsjf oiasdjfoi jsdafoij sdoifjdsoifjasdoifj adf iasdjf oiasdjf iodsjsdoifjdsoifjasdoifj adf iasdjf oiasdjf iodsjsdoifjdsoifjasdoifj adf iasdjf oiasdjf iodsjsdoifjdsoifjasdoifj adf iasdjf oiasdjf iodsjsdoifjdsoifjasdoifj adf iasdjf oiasdjf iodsjsdoifjdsoifjasdoifj adf iasdjf oiasdjf iodsjsdoifjdsoifjasdoifj adf iasdjf oiasdjf iodsjsdoifjdsoifjasdoifj adf iasdjf oiasdjf iodsjsdoifjdsoifjasdoifj adf iasdjf oiasdjf iodsj foiasdjf iods")
    }
}

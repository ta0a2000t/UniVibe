//
//  SectionAndSelectionsView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI
struct SectionAndSelectionsView: View {
    var title: String
    @Binding var selections: [String]
    
    @State private var totalHeight = CGFloat.zero // To dynamically set the height
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("\(title) (\(selections.count))")
                .font(.title2)
                .bold()
            
            HStack(alignment: .center) {
                

                if selections.isEmpty {
                    Spacer()
                    Text("No items").padding(.top)
                        .foregroundColor(.gray)
                    Image(systemName: "exclamationmark.circle").padding(.top)
                        .foregroundColor(.gray)
                    Spacer()
                    
                }

                
            }
            

            
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
            Spacer()
        }
        .frame(height: totalHeight).padding(.top, 50).padding(.bottom, 30)
// Set the height
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.selections, id: \.self) { tag in
                self.item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if abs(width - d.width) > g.size.width {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.selections.last! {
                            width = 0 // last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if tag == self.selections.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func item(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
            .font(.body)
            .background(Color.red.opacity(0.2))
            .cornerRadius(12)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}


struct SectionAndSelectionsView_Previews: PreviewProvider {
    static var previews: some View {
        SectionAndSelectionsView(title: "Interests", selections:
                .constant(["Out1ddoor", "Painti44ng","Outd32door", "Paint4ddging", "Swimming", "Out1ddoo1r", "Painti441ng","Outd321door", "Paint4dd1ging", "Swimm3ing"]))
    }
}

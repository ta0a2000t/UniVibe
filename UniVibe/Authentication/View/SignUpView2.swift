//
//  SignUpView.swift
//  Gharrid
//
//  Created by Taha Al on 8/13/23.
//

import SwiftUI

struct SignUpView2: View {
    @State private var interests: [String] = ["Outdoor", "Board Games", "Video Games"]
    @State private var communitiesIDs: [String] = ["adisjfoisdj"]
    @EnvironmentObject var registrationViewModel : RegistrationViewModel
    @Environment(\.dismiss) var dismiss
    
    //@StateObject var validator = SignUpView2Validator()

    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Personalize Profile").font(.largeTitle).foregroundColor(.purple).padding(.bottom, 30).fontDesign(.rounded).bold()
                
                // texts
                VStack {
                    
                    Text("Interests: ")
                    Text("Communities: ")
                    
                }
                

                
                NavigationLink {
                    SignUpView3().environmentObject(registrationViewModel).navigationBarBackButtonHidden(true)
                } label: {
                    Text("Next")
                        .font(.headline)
                        .frame(width: 250, height:50)
                        .cornerRadius(25)
                }.onTapGesture {
                    nextClicked()
                }.disabled(interests.isEmpty || communitiesIDs.isEmpty).buttonStyle(GrowingButton(enabledColor: .purple))
                .padding(.vertical, 30)

                
                Spacer()
                

                
            }
        }.toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left").foregroundColor(.purple)
                }
            }
            
            ToolbarItem(placement: .principal) {
                LogoOnTopMiddleView()
            }
            
        
            
        }
    }
    
    func nextClicked() {
        registrationViewModel.interests = interests
                                                // making a copy
        registrationViewModel.communitiesIDs = communitiesIDs.map { $0 }
    }
}

struct SignUpView2_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView2()
    }
}

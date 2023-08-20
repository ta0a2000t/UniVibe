//
//  SignUpView.swift
//  Gharrid
//
//  Created by Taha Al on 8/13/23.
//

import SwiftUI

struct SignUpView1: View {
    @EnvironmentObject var registrationViewModel : RegistrationViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var validator = SignUpView1Validator()

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Vibe with us!").font(.largeTitle).foregroundColor(.purple).padding(.bottom, 30).fontDesign(.rounded).bold()
                
                // texts
                VStack {
                    
                    // restrict input to only english letters
                    TextField("Enter your name", text: Binding(
                        get: { validator.fullname },
                        set: { newValue in
                            if newValue.isValidFullname() {
                                validator.fullname = newValue
                            }
                        }
                    ))
                    .modifier(MyTextFieldModifier())
                    
                    
                    TextField("Enter a short bio", text: $validator.bio)
                        .textInputAutocapitalization(.never)
                        .modifier(MyTextFieldModifier())
                }
                

                
                NavigationLink {
                    SignUpView2().environmentObject(registrationViewModel).navigationBarBackButtonHidden(true)
                } label: {
                    Text("Next")
                        .font(.headline)
                        .frame(width: 250, height:50)
                        .cornerRadius(25)
                }.onTapGesture {
                    nextClicked()
                }.disabled(!validator.formIsValid).buttonStyle(GrowingButton(enabledColor: .purple))
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
        registrationViewModel.fullname = validator.fullname
        registrationViewModel.bio = validator.bio
    }
    
}

struct SignUpView1_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView1()
    }
}

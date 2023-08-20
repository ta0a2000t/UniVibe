//
//  SignUpView3.swift
//  UniVibe
//
//  Created by Taha Al on 8/19/23.
//

import Foundation
import SwiftUI

struct SignUpView3: View {
    @EnvironmentObject var registrationViewModel : RegistrationViewModel
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var validator = SignUpView3Validator()
    
    @State var showNextView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Vibe With Us!").font(.largeTitle).foregroundColor(.purple).padding(.bottom, 30).fontDesign(.rounded).bold()
                
                // texts
                VStack {
                    TextField("Create a username", text: $validator.userName)
                        .modifier(MyTextFieldModifier()).textInputAutocapitalization(.none)
                    
                    TextField("Enter an email", text: $validator.userEmail)
                        .modifier(MyTextFieldModifier()).padding(.bottom)
                    
                    
                    SecureField("Enter a password", text: $validator.userPassword)
                        .textInputAutocapitalization(.never)
                        .modifier(MyTextFieldModifier())
                    SecureField("Repeat password", text: $validator.userRepeatedPassword)
                        .textInputAutocapitalization(.never)
                        .modifier(MyTextFieldModifier())
            
                }
                


                
                Button {
                    completeSignUpClicked()
                } label: {
                    Text("Complete Sign Up")
                        .font(.headline)
                        .frame(width: 250, height:50)
                        .cornerRadius(25)
                }.disabled(!validator.formIsValid).buttonStyle(GrowingButton(enabledColor: .purple))
                .padding(.vertical, 30).onTapGesture {
                    completeSignUpClicked()
                }

                

                
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
            
        
            
        }.navigationDestination(isPresented: $showNextView) {
            CompleteSignUpView().environmentObject(registrationViewModel).navigationBarBackButtonHidden(true)
        }
        
        
    }
    
    func completeSignUpClicked() {
        
        registrationViewModel.username = validator.userName
        registrationViewModel.email = validator.userEmail
        registrationViewModel.password = validator.userPassword
        
        showNextView = true
    }
    
}

struct SignUpView3_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView3()
    }
}

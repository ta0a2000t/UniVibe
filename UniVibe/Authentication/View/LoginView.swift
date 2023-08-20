//
//  LoginView.swift
//  Gharrid
//
//  Created by Taha Al on 8/13/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    @EnvironmentObject var registrationViewModel : RegistrationViewModel
    
    @StateObject var validator = LoginViewValidator()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // logo img
                Image("univibe_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .padding(.bottom).padding(.bottom)
                
                // texts
                VStack {
                    TextField("Enter your email", text: $validator.userEmail)
                        .textInputAutocapitalization(.never)
                        .modifier(MyTextFieldModifier())
                    
                    SecureField("Enter your password", text: $validator.userPassword)
                        .modifier(MyTextFieldModifier())
                }
                
                Button {
                    print("forgot password clicked")
                } label : {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                    
                }
                
                Button {
                    loginIsClicked()

                } label: {
                    Text("Login")
                        .font(.headline)
                        .frame(width: 250, height:50)
                        .cornerRadius(25)
                }.disabled(!validator.formIsValid).buttonStyle(GrowingButton(enabledColor: .purple))
                    .padding(.vertical, 30)
                
                
                
                
                Spacer()
                
                NavigationLink {
                    SignUpView1().navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign Up!")
                            .fontWeight(.semibold)
                        Image(systemName: "face.smiling")
                    }
                }.padding(.bottom)
                
            }
        }
    }
    
    func loginIsClicked() {
        print("login button")
        
        loginViewModel.email = validator.userEmail
        loginViewModel.password = validator.userPassword
        
        Task{ try await loginViewModel.signIn()}
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

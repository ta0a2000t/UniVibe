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
    @State private var isLoading: Bool = false
    let errorMessage: String = "Incorrect Email or Password."
    @State var showErrorAlert: Bool = false
    

    // TODO: use this navigationPath thing to navigate
    @State var navigationStackPath = NavigationPath()

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
                        .textInputAutocapitalization(.never).keyboardType(.emailAddress)
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
                    SignUpView1(navigationStackPath: $navigationStackPath).environmentObject(registrationViewModel)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign Up!")
                            .fontWeight(.semibold)
                        Image(systemName: "face.smiling")
                    }
                }.environmentObject(registrationViewModel).padding(.bottom)
                
            }
        }.modifier(ActivityIndicatorModifier(isLoading: isLoading)).alert("Sign In Failed :(", isPresented: $showErrorAlert) {
            
            Button("Try Again") {
                

            }
        } message: {
            Text(errorMessage)
        }
    }
    
    func loginIsClicked() {
        print("login button")
        
        loginViewModel.email = validator.userEmail
        loginViewModel.password = validator.userPassword
        
        
        
        Task {
            isLoading = true
            do {
                try await loginViewModel.signIn()
                isLoading = false
            } catch{
                //print(error.localizedDescription)
                isLoading = false
                showErrorAlert = true
            }
            
            
        }

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

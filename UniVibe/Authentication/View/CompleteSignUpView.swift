//
//  CompleteSignUpView.swift
//  Gharrid
//
//  Created by Taha Al on 8/13/23.
//

import SwiftUI

struct CompleteSignUpView: View {
    @State private var isLoading: Bool = false

    @EnvironmentObject var registrationViewModel: RegistrationViewModel
    @Environment(\.dismiss) var dismiss
    @State var showCreationFailedAlert: Bool = false
    @State var creationErrorMessage: String = ""
    @Binding var navigationStackPath : NavigationPath

    var body: some View {
    
            
                VStack {
                    Spacer()
                    Text("Your Info Is Complete! \(registrationViewModel.username)").font(.title2).foregroundColor(.purple).bold()
                    
                    
                    
                    Button {
                        createAccountClicked()
                        
                    } label: {
                        Text("Create Account")
                            .font(.headline)
                            .frame(width: 250, height:50)
                            .cornerRadius(25)
                    }.buttonStyle(GrowingButton(enabledColor: .purple))
                        .padding(.vertical, 30)
                    
                    Spacer()
                    
                    
                    
                }
                
            
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                LogoOnTopMiddleView()
            }
            
        
            
        }.modifier(ActivityIndicatorModifier(isLoading: isLoading))
        .alert("Sign Up Failed :(", isPresented: $showCreationFailedAlert) {
            
            Button("OK") {dismiss()}
        } message: {
            Text(creationErrorMessage)
        }




            
    }
    
    func createAccountClicked() {
        isLoading = true
        
        Task {
            do {
                try await registrationViewModel.createUser()
                isLoading = false
                
            } catch {
                isLoading = false
                
                showCreationFailedAlert = true
                creationErrorMessage = error.localizedDescription
            }
        }
        
    }
}

struct CompleteSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        //CompleteSignUpView()
        EmptyView()
    }
}




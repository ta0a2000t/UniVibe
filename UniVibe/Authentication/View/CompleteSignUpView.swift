//
//  CompleteSignUpView.swift
//  Gharrid
//
//  Created by Taha Al on 8/13/23.
//

import SwiftUI

struct CompleteSignUpView: View {
    @State var showLoading = false

    @EnvironmentObject var registrationViewModel: RegistrationViewModel
    @Environment(\.dismiss) var dismiss
    @State var disableButton: Bool = false
    @State var showCreationFailedAlert: Bool = false
    @State var creationErrorMessage: String = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                    Spacer()
                    Text("Your Info Is Complete! \(registrationViewModel.username)").font(.title2).foregroundColor(.purple).bold()
                    
                    
                    
                    Button {
                        disableButton = true
                        showLoading = true
                        
                        Task {
                            do {
                                try await registrationViewModel.createUser()
                                showLoading = false
                                
                            } catch {
                                showLoading = false
                                
                                showCreationFailedAlert = true
                                creationErrorMessage = error.localizedDescription
                            }
                        }
                        
                        
                    } label: {
                        Text("Create Account")
                            .font(.headline)
                            .frame(width: 250, height:50)
                            .cornerRadius(25)
                    }.buttonStyle(GrowingButton(enabledColor: .purple))
                        .padding(.vertical, 30).disabled(disableButton)
                    
                    Spacer()
                }
                
                if showLoading { LoadingView() }
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
            
        
            
        }.alert("Sign Up Failed :(", isPresented: $showCreationFailedAlert) {
            
            Button("OK") {dismiss()}
        } message: {
            Text(creationErrorMessage)
        }.animation(.default, value: showLoading)




            
    }
}

struct CompleteSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignUpView()
    }
}



struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.75)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressView()
                Text("Loading...")
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: 200, height: 200)
            }
            .offset(y: -70)
        }
    }
}

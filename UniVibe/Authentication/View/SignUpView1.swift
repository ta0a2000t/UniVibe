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
    @State var showNextView: Bool = false
    @Binding var navigationStackPath : NavigationPath

    var body: some View {
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
                

                
                Button {
                    nextClicked()
                } label: {
                    Text("Next")
                        .font(.headline)
                        .frame(width: 250, height:50)
                        .cornerRadius(25)
                }.disabled(!validator.formIsValid).buttonStyle(GrowingButton(enabledColor: .purple))
                .padding(.vertical, 30)
                    
                
                Spacer()
                
            }
        .toolbar {

            
            ToolbarItem(placement: .principal) {
                LogoOnTopMiddleView()
            }
            
        
            
        }.navigationDestination(isPresented: $showNextView) {
            SignUpView2(navigationStackPath: $navigationStackPath).environmentObject(registrationViewModel)
        }
        
    }
    
    func nextClicked() {
        registrationViewModel.fullname = validator.fullname
        registrationViewModel.bio = validator.bio
        showNextView = true
    }
    
}

struct SignUpView1_Previews: PreviewProvider {
    static var previews: some View {
        //SignUpView1()
        Text("")
    }
}

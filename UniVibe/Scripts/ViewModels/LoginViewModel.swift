//
//  LoginViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/19/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}

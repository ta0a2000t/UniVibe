//
//  LoginViewValidator.swift
//  UniVibe
//
//  Created by Taha Al on 8/20/23.
//

import Foundation
import Combine

// by blorenzo10
final class LoginViewValidator: ObservableObject {
    
    // Input values from View
    @Published var userEmail = ""
    @Published var userPassword = ""
  
    // Output subscribers
    @Published var formIsValid = false
    
    private var publishers = Set<AnyCancellable>()
    
    init() {
        isSignupFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &publishers)
    }
}

// MARK: - Setup validations

private extension LoginViewValidator {
    
    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
        $userEmail
            .map { email in
                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                return emailPredicate.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $userPassword
            .map { password in
                return password.count >= 8
            }
            .eraseToAnyPublisher()
    }
    
    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isUserEmailValidPublisher,
            isPasswordValidPublisher
        )
        .map { isEmailValid, isPasswordValid in
            return isEmailValid && isPasswordValid
        }
        .eraseToAnyPublisher()
    }
}

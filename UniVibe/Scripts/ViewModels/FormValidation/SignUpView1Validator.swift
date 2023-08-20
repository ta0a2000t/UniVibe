//
//  SignUpView1Validator.swift
//  UniVibe
//
//  Created by Taha Al on 8/20/23.
//

import Foundation
import Combine

// by blorenzo10
final class SignUpView1Validator: ObservableObject {
    
    // Input values from View
    @Published var fullname = ""
    @Published var bio = ""
  
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

private extension SignUpView1Validator {
    
    var isFullnameValidPublisher: AnyPublisher<Bool, Never> {
        $fullname
            .map { fullname in
                let regex = try! NSRegularExpression(pattern: "^[a-zA-Z\\s]*$", options: [])
                let range = NSRange(location: 0, length: fullname.utf16.count)
                let matches = regex.matches(in: fullname, options: [], range: range)
                return matches.count == 1 && fullname.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    var isBioValidPublisher: AnyPublisher<Bool, Never> {
        $bio
            .map { bio in
                return bio.trimmingCharacters(in: .whitespacesAndNewlines).count >= 10
            }
            .eraseToAnyPublisher()
    }
    
    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isFullnameValidPublisher,
            isBioValidPublisher
        )
        .map { isFullnameValid, isBioValid in
            return isFullnameValid && isBioValid
        }
        .eraseToAnyPublisher()
    }
}

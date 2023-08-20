//
//  SignUpView2Validator.swift
//  UniVibe
//
//  Created by Taha Al on 8/20/23.
//

import Foundation
import Combine

// by blorenzo10
final class SignUpView2Validator: ObservableObject {
    
  // Input values from View
    @Published var communityIDs : [String] = []
    @Published var interests : [String] = []
  
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
private extension SignUpView2Validator {
    
    var areCommunityIDsValidPublisher: AnyPublisher<Bool, Never> {
        $communityIDs
            .map { communityIDs in
                // Implement your validation logic for communityIDs here
                // For example, check if the array is not empty
                return !communityIDs.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    var areInterestsValidPublisher: AnyPublisher<Bool, Never> {
        $interests
            .map { interests in
                // Implement your validation logic for interests here
                // For example, check if the array is not empty
                return !interests.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            areCommunityIDsValidPublisher,
            areInterestsValidPublisher
        )
        .map { areCommunityIDsValid, areInterestsValid in
            return areCommunityIDsValid && areInterestsValid
        }
        .eraseToAnyPublisher()
    }
}

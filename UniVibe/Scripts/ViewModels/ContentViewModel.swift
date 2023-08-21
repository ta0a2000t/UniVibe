//
//  ContentViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/19/23.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth

@MainActor
class ContentViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellable)
        
        
        AuthService.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }.store(in: &cancellable)
    }
}

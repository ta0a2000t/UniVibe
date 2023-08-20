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
    private let service = AuthService.shared
    private var cancellable = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        setupSubscribers()
        
    }
    
    
    func setupSubscribers() {
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
            
        }.store(in: &cancellable)
    }
}

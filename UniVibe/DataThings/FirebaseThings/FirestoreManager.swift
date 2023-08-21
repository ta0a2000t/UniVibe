//
//  FirestoreManager.swift
//  UniVibe
//
//  Created by Taha Al on 8/18/23.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    static let shared = FirestoreManager()

    let db: Firestore

    private init() {
        db = Firestore.firestore()
    }
    

}

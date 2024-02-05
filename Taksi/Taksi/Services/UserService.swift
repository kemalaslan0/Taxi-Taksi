//
//  UserService.swift
//  Taksi
//
//  Created by Kemal Aslan on 15.01.2024.
//

import Firebase
//import FirebaseFirestoreSwift

class UserService: ObservableObject{
    
    static let shared = UserService()
    @Published var user: User?
    
    init() {
        fetchUser()
    }
        func fetchUser() {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                print("DEBUG: Service currentUser \(user.fullName)")
                self.user = user
            }
        }
}

//
//  AuthViewModel.swift
//  Taksi
//
//  Created by Kemal Aslan on 14.01.2024.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift
import Combine

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    private let service = UserService.shared
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func signIn(withEmail email:String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                print("DEBUG: Failed to sign up \(error.localizedDescription )")
                return
            }
            
            self.userSession = result?.user
            self.fetchUser()
        }
    }
    
    func registerUser(withEmail email: String, password: String, fullName:String){
        
        guard let location = LocationManager.shared.userLocation else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                print("DEBUG: Failed to sign up \(error.localizedDescription )")
                return
            }
            guard let firebaseUser = result?.user else { return }
            self.userSession = firebaseUser

            let user = User(fullName: fullName,
                            email: email,
                            uid: firebaseUser.uid,
                            coordinate: GeoPoint(latitude: location.latitude, longitude: location.longitude),
                            accountType: .driver)

            guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
            Firestore.firestore().collection("users").document(firebaseUser.uid).setData(encodedUser)
            
            self.currentUser = user
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }catch {
            print("DEBUG : Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    func fetchUser(){
        service.$user
            .sink { user in
                self.currentUser = user
                print("DEBUG : Current User AuthView\(user?.fullName ?? "Empty")")
            }
            .store(in: &cancellable)
    }
}

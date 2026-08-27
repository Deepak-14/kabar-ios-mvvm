//
//  ProfileViewModel.swift
//  Kabar
//
//  Created by user on 26/08/26.
//

import Observation
import SwiftUI
import FirebaseAuth

@MainActor
@Observable
class ProfileViewModel{
    var email: String = ""
    
    func userLogout() async -> Bool {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            return true
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            return false
        }
    }
    
    func fetchUser()  {
        let user = Auth.auth().currentUser
        if let user = user {
          let uid = user.uid
            email = user.email ?? ""
        }
    }
    
}

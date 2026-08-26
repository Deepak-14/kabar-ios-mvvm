//
//  LoginViewModel.swift
//  Kabar
//
//  Created by user on 26/08/26.
//

import FirebaseAuth
import SwiftUI

@MainActor
@Observable
class LoginViewModel{

    var email = ""
    var password = ""

    var emailError: String?
    var passwordError: String?
    var isLoading = false
    
    func validate() -> Bool {
            emailError = nil
            passwordError = nil
            
            var isValid = true

            // Email validation
            if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                emailError = "Email is required"
                isValid = false
            } else if !email.isValidEmail() {
                emailError = "Please enter a valid email address"
                isValid = false
            }

            // Password validation
            if password.isEmpty {
                passwordError = "Password is required"
                isValid = false
            } else if password.count < 6 {
                passwordError = "Password must contain at least 6 characters"
                isValid = false
            }
            return isValid
        }

        
    
    func createUser(email: String, password: String, completion: @escaping (Bool)-> Void)  {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            guard let error = error as? NSError, error.code == 17007 else{
                completion(false)
                return
            }
            
            if error.code == 17007{
                Auth.auth().signIn(withEmail: email, password: password) {[weak self]  authResultSignIn, errorSignIn in
                    guard let strongSelf = self else { return }
                    
                    if errorSignIn != nil{
                        completion(false)
                        return
                    }
                    
                    if let _ = authResultSignIn{
                        // Set User Login State
                        completion(true)
                    }else{
                        completion(false)
                    }
                }
            }else{
                if let _ = authResult{
                    // Set User Login State                    
                    completion(true)
                }else{
                    completion(false)
                }
            }
            
            
        }
    }
}

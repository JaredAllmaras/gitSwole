//
//  AuthUser.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/22/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseAuth

/**
 *  Firebase User wrapper service (singleton)
 */
class AuthService {
    
    // TODO: Recover childByAutoID key when a user logs in
    
    static let user = AuthService()
    
    private var auth: Auth?
    private var user: FirebaseAuth.User?
    
    private init() {
        auth = nil
        user = nil
    }
    
    func setAuthListener() {
        auth = Auth.auth()
        auth?.addStateDidChangeListener({ (auth, user) in
            if auth.currentUser != nil {
                // successfully signed in
                print("Detected user... ")
//                print(Store.store.getUsername() + " successfully signed in!")
                self.user = user
            }
        })
    }
    
    func signUp(_ email:String, _ password:String, _ viewController:SignUpProtocol) {
        
        auth?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
//                DatabaseService.dataSource.createAndLoadUser(user!.uid)
                viewController.proceed()
            } else {
                print(error!.localizedDescription)
                var errorMessage:String
                switch (error!.localizedDescription) {
                case "The email address is already in use by another account.":
                    errorMessage = "This email address is already in use"
                case "The password must be 6 characters long or more.":
                    errorMessage = "Password must be > 6 characters"
                default:
                    errorMessage = "Internal Error!"
                }
                
                viewController.error(errorMessage)
            }
        })
    }
    
    func signIn(_ email:String, _ password:String, _ viewController:SignUpProtocol) {
        auth?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                DatabaseService.dataSource.loadUser(user!.uid, viewController)
            } else {
                viewController.error(error!.localizedDescription)
            }
        })
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            Store.store.unloadUserState()
            DatabaseService.dataSource.unloadUserState()
         } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getUserID() -> String {
        return user!.uid
    }
    
    func signedIn() -> Bool {
        return (auth!.currentUser != nil)
    }
}

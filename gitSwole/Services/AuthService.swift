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
    
    func signUp(_ username:String, _ email:String, _ password:String) {
//        guard !signedIn() else {
//            // deal with error
//            print("User is already signed in")
//            return
//        }
        
        
        auth?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                DatabaseService.dataSource.createAndLoadUser(user!.uid, username)
                print(Store.store.getUsername() + " successfully signed up!")
            } else {
                // TODO: guard against already signed up
                print("Error creating user")
                print(error!.localizedDescription)
            }
        })
    }
    
    func signIn(_ email:String, _ password:String) {
//        guard !signedIn() else {
//            print("User is already signed in")
//            return
//        }
        
        auth?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                DatabaseService.dataSource.loadUser(user!.uid)
            } else {
                print("Error signing in")
                print(error!.localizedDescription)
            }
        })
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            Store.store.unloadUserState()
            print(Store.store.getUsername() + " successfully signed out!")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func signedIn() -> Bool {
        return (auth!.currentUser != nil)
    }
}

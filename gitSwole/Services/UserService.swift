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
class UserService {
    
    // TODO: Recover childByAutoID key when a user logs in
    
    static let user = UserService()
    
    private var auth: Auth?
    private var user: FirebaseAuth.User?
    
    private init() {
        auth = nil
        user = nil
    }
    
    func configure() {
        auth = Auth.auth()
        auth?.addStateDidChangeListener({ (auth, user) in
            if auth.currentUser != nil {
                print(user!)
                self.user = user
            }
        })
    }
    
    // create user and save userID
    func signUp(_ username:String, _ email:String, _ password:String) {
//        guard !signedIn() else {
//            // deal with error
//            print("User is already signed in")
//            return
//        }
        
        
        auth?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                DatabaseService.dataSource.createUserDatabase(user!.uid, username)
            } else {
                // TODO: guard against already signed up
                print("Error creating user")
                print(error!.localizedDescription)
            }
        })
    }
    
    // sign user in and save userID
    func signIn(_ email:String, _ password:String) {
//        guard !signedIn() else {
//            print("User is already signed in")
//            return
//        }
        
        auth?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                DatabaseService.dataSource.configureUserDatabase(user!.uid)
                print("Sign in was successful")
            } else {
                print("Error signing in")
                print(error!.localizedDescription)
            }
        })
    }
    
    /**
     *  Returns Firebase's internal user ID for the user
     */
//    func getUID() -> String? {
//        guard signedIn() else {
//            print("Error: Trying to access UID when not signed in" )
//            return nil
//        }
//
//        return user!.uid
//    }
    
    private func signedIn() -> Bool {
        return (auth?.currentUser != nil)
    }
}

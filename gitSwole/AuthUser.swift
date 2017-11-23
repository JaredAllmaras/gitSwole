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
 *  FirebaseAuth wrapper (singleton object)
 */
class AuthUser {
    static let user = AuthUser()
    
    private var auth: Auth?
    private var userID: String?
    
    private init() {
        auth = nil
        userID = nil
    }
    
    func configure() {
        auth = Auth.auth()
    }
    
    // create user and save userID
    func signUp(_ username:String, _ email:String, _ password:String) {
        guard !signedIn() else {
            // deal with error
            print("User is already signed in")
            return
        }
        
        // guard against already signed up
        
        auth?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                user?.getIDToken(completion: { (uid, error) in
                    if error == nil {
                        self.userID = uid
                        DataSource.dataSource.createUser(uid!, username)
                    } else {
                        // deal with error
                        print("Error creating user")
                        print(error!.localizedDescription)
                    }
                })
            }
        })
    }
    
    // sign user in and save userID
    func signIn(_ email:String, _ password:String) {
        guard !signedIn() else {
            print("User is already signed in")
            return
        }
        
        auth?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                user?.getIDToken(completion: { (uid, error) in
                    if error == nil {
                        print("Sign in was successful")
                        self.userID = uid
                        DataSource.dataSource.signIn()
                    } else {
                        print("Error signing in")
                        print(error!.localizedDescription)
                    }
                })
            }
        })
    }
    
    func getUserFBID() -> String? {
        guard signedIn() else {
            print("Error: Trying to retrieve FBID when not signed in")
            return nil
        }
        
        return userID
    }
    
    private func signedIn() -> Bool {
        return (userID != nil)
    }
}

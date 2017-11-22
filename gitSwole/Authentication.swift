//
//  Authentication.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseAuth

class Authentication {
    
//    private static let auth: Auth! = Auth.auth()
//    private static var user: FirebaseAuth.User?
//    private static var responseReceived:Bool = false
//
//    static func signUp(email:String, password:String) -> FirebaseAuth.User? {
//        Authentication.auth.createUser(withEmail: email, password: password, completion: { (user, error) in
//            if error == nil {
//                Authentication.user = user
//            } else {
//                print(error!.localizedDescription)
//            }
//            Authentication.responseReceived = true
//        })
//        block() // block because next view controller depends on value of user
//        return Authentication.user
//    }
//
//    func signIn(email:String, password:String) -> FirebaseAuth.User? {
//        Authentication.auth.signIn(withEmail: email, password: password) { (user, error) in
//
//        }
//        return Authentication.user
//    }
//
//    private static func block() {
//        while (!Authentication.responseReceived) {}
//        Authentication.responseReceived = false
//    }
}

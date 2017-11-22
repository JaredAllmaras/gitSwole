//
//  DataSource.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class DataSource {
    
    static let dataSource = DataSource()
    
    private let dbref: DatabaseReference!
    private var user: FirebaseAuth.User?
    
    init() {
        dbref = Database.database().reference()
        user = nil
    }
    
    func configure(user: FirebaseAuth.User) {
        self.user = user
    }
    
    func signedIn() -> Bool {
        return user != nil
    }
    
    func test() {
        if signedIn() {
            let _ = user?.getIDToken(completion: { (id, error) in
                if error == nil {
                    self.dbref.setValue(id)
                } else {
                    print("Error: Failed to fetch User ID")
                }
            })
        } else {
            print("Not logged in")
        }
    }
}



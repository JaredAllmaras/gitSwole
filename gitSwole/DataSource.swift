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
    private var uid: DatabaseReference!
    
    init() {
        dbref = Database.database().reference()
        user = nil
        uid = nil
    }
    
    func addUser(_ user: FirebaseAuth.User, _ username: String) {
        if signedIn() {
            uid = dbref.child("users").childByAutoId()
            let userDataModel = ["username": username]
            uid.setValue(userDataModel)
        } else {
            print("Not logged in")
        }
    }
    
    func configure(user: FirebaseAuth.User) {
        self.user = user
    }
    
    func signedIn() -> Bool {
        return user != nil
    }
    
    // goal weight, current weight, current meal plan
    func addCurrentMealPlan(_ mealPlan:Int) {
        if signedIn() {
            uid.setValue(["mealPlan": mealPlan])
            uid.up
        } else {
            print("Not signed in")
        }
    }
    
    func addGoalWeight
    
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



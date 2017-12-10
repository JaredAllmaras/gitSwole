//
//  Exercise.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/23/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Exercise {
    
    // MARK: - FirebaseModel Metadata
    let key: String
    let ref: DatabaseReference!
    
    // MARK: - Fields
    
    let name: String
    let sets: Int
    let reps: Int
    
    // MARK: - Constructors
    
    init() {
        key = ""
        ref = nil
        
        name = ""
        sets = 0
        reps = 0
    }
    
    init(name:String, sets:Int, reps:Int, key: String = "") {
        self.key = key
        ref = nil
        
        self.name = name
        self.sets = sets
        self.reps = reps
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        let snapshotValue = snapshot.value as! [String:Any]
        name = snapshotValue["name"] as! String
        sets = snapshotValue["sets"] as! Int
        reps = snapshotValue["reps"] as! Int
    }
    
    // MARK: - Map
    
    func toMap() -> [String:Any] {
        return [
            "name": name,
            "sets": sets,
            "reps": reps,
        ]
    }
}

//
//  Course.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/29/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Course {
    
    // MARK: - FirebaseModel Metadata
    
    let key: String
    let ref: DatabaseReference!
    
    // MARK: - Fields
    
    let name: String
    let servingSize: String // TODO: Change this to an int
    
    // MARK: - Constructors
    
    init() {
        key = ""
        ref = nil
        
        name = ""
        servingSize = ""
    }
    
    init(name: String, servingSize: String, key: String = "") {
        self.key = ""
        ref = nil
        
        self.name = name;
        self.servingSize = servingSize;
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        let snapshotValue = snapshot.value as! [String:Any]
        name = snapshotValue["name"] as! String
        servingSize = snapshotValue["serving-size"] as! String
    }
    
    // MARK: - Map
    
    func toMap() -> [String:Any] {
        return [
            "name": name,
            "serving-size": servingSize,
        ]
    }
    
}

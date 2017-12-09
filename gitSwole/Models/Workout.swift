//
//  Workout.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Workout {
    
    // MARK: - FirebaseModel Metadata
    let key: String
    let ref: DatabaseReference!
    
    // MARK: - Fields
    
    let name:String
    let muscleGroup:String
    var exercises:[Exercise]
    
    // MARK: - Constructors
    
    init() {
        key = ""
        ref = nil
        
        name = ""
        muscleGroup = ""
        exercises = []
    }
    
    init(name:String, muscleGroup:String, exercises:[Exercise], key: String = "") {
        self.key = key
        ref = nil
        
        self.name = name
        self.muscleGroup = muscleGroup
        self.exercises = exercises
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        let snapshotValue = snapshot.value as! [String:Any]
        name = snapshotValue["name"] as! String
        muscleGroup = snapshotValue["muscle-group"] as! String
        exercises = []
        for exerciseSnapshot in snapshot.childSnapshot(forPath: "exercises").children {
            exercises.append(Exercise(snapshot: exerciseSnapshot as! DataSnapshot))
        }
    }
    
    // MARK: - Map
    
    func toMap() -> [String:Any] {
        
        var exerciseMaps:[[String:Any]] = []
        
        for exercise in exercises {
            exerciseMaps.append(exercise.toMap())
        }
        
        return [
            "name": name,
            "muscle-group": muscleGroup,
            "exercises": exerciseMaps
        ]
    }
}

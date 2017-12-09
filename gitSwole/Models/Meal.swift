//
//  Meal.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Meal {
    
    // MARK: - FirebaseModel Metadata
    let key:String
    let ref:DatabaseReference!
    
    // MARK: - Fields
    
    let calories:Int
    let firstCourse:Course
    let secondCourse:Course
    let thirdCourse:Course
    
    // MARK: - Constructors
    
    init() {
        key = ""
        ref = nil
        
        calories = 0
        firstCourse = Course()
        secondCourse = Course()
        thirdCourse = Course()
    }
    
    // send model to Firebase
    // key is for when you want to specify which database key to updates
    init(calories: Int, first: Course, second: Course, third: Course, key: String = "") {
        self.key = key
        ref = nil
        
        self.calories = calories
        self.firstCourse = first
        self.secondCourse = second
        self.thirdCourse = third
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        let snapshotValue = snapshot.value as! [String:Any]
        calories = snapshotValue["calories"] as! Int
        firstCourse = Course(snapshot: snapshot.childSnapshot(forPath: "first-course"))
        secondCourse = Course(snapshot: snapshot.childSnapshot(forPath: "second-course"))
        thirdCourse = Course(snapshot: snapshot.childSnapshot(forPath: "third-course"))
    }
    
    // MARK: - To Map
    
    func toMap() -> [String:Any] {
        return [
            "calories": calories,
            "first-course": firstCourse.toMap(),
            "second-course": secondCourse.toMap(),
            "third-course": thirdCourse.toMap(),
        ]
    }
}

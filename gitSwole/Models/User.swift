//
//  UserDataModel.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct User {
    
    // MARK: - FirebaseModel Metadata
    
    let key:String
    let ref:DatabaseReference!
    
    // MARK: - Fields

    let id: String?
    var profileImage: UIImage? // TODO: Complete this
    let username: String
    let currentHeight: Int
    let currentWeight: Int
    let goalWeight: Int
    
    var mealplans: [MealPlan]
    var workouts: [Workout]
    
    var currentMealPlanIndex: Int
    var currentMealIndex: Int
    
    
    // MARK: - Constructors
    
    init() {
        key = ""
        ref = nil
        
        id = ""
        username = ""
        currentHeight = 0
        currentWeight = 0
        goalWeight = 0
        
        mealplans = []
        workouts = []
        
        currentMealPlanIndex = 0
        currentMealIndex = 0
    }
    
    init(username: String,
         currentHeight: Int,
         currentWeight: Int,
         goalWeight: Int,
         mealPlans: [MealPlan] = [],
         workouts: [Workout] = [],
         currentMealPlanIndex: Int = 0,
         currentMealIndex: Int = 0,
         key: String = "")
    {
        self.key = key
        ref = nil
        id = nil
        
        self.username = username
        self.currentHeight = currentHeight
        self.currentWeight = currentWeight
        self.goalWeight = goalWeight
        
        self.mealplans = mealPlans
        self.workouts = workouts
        
        self.currentMealPlanIndex = currentMealPlanIndex
        self.currentMealIndex = currentMealIndex
    }
    
    // loading user from auth and database
    init(user: FirebaseAuth.User?, snapshot: DataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        
        let snapshotValue = snapshot.value as! [String:Any]
        
        id = user?.uid
        username = snapshotValue["username"] as! String
        currentHeight = snapshotValue["current-height"] as! Int
        currentWeight = snapshotValue["current-weight"] as! Int
        goalWeight = snapshotValue["goal-weight"] as! Int
        
        mealplans = []
        for mealplanSnapshot in snapshot.childSnapshot(forPath: "meal-plans").children {
            mealplans.append(MealPlan(snapshot: mealplanSnapshot as! DataSnapshot))
        }
        
        workouts = []
        for workoutSnapshot in snapshot.childSnapshot(forPath: "workouts").children {
            workouts.append(Workout(snapshot: workoutSnapshot as! DataSnapshot))
        }
        
//        currentMealPlanIndex = snapshotValue["current-meal-plan-index"] as! Int
        currentMealPlanIndex = 0
        currentMealIndex = 0
    }
    
    // MARK - Map
    
    func toMap() -> [String:Any] {
        
        var mealplanMaps = [[String:Any]]()
        var workoutMaps = [[String:Any]]()
        
        for mealplan in mealplans {
            mealplanMaps.append(mealplan.toMap())
        }
        
        for workout in workouts {
            workoutMaps.append(workout.toMap())
        }
        
        return [
            "username": username,
            "current-height": currentHeight,
            "current-weight": currentWeight,
            "goal-weight": goalWeight,
            "meal-plans": mealplanMaps,
            "workouts": workoutMaps,
            "current-meal-plan-index": currentMealPlanIndex,
            "current-meal-index": currentMealIndex
        ]
    }
}

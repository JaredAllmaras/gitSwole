//
//  DataSource.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseDatabase

/**
 *  FirebaseDatabaseReference wrapper (singleton object)
 */
class DatabaseService {
    
    static let dataSource = DatabaseService()
    
    private var dbref: DatabaseReference?
    private var userDBRef: DatabaseReference?
    
    private init() {
        dbref = nil
        userDBRef = nil
    }
    
    func configure() {
        dbref = Database.database().reference().child("app")
    }
    
    func createAndLoadUser(_ firAuthUserID:String, _ username:String) {
        print("Creating user in Firebase..")
        
        // generate new user in database
        userDBRef = dbref?.child("users").childByAutoId()

        // save key-value pair [firAuthUserID: FIRDatabaseAutoID] to local storage
        let firDatabaseAutoID = userDBRef!.key
        let defaults = UserDefaults.standard
        defaults.set(firDatabaseAutoID, forKey: firAuthUserID)
        
        // create user entry
        let currentMealPlan = Store.store.getDefaultMealPlan()
        let currentWeight = 170
        let goalWeight = 150
        
        let userState = UserState(username: username,
                             currentMealPlan: currentMealPlan,
                             currentWeight: currentWeight,
                             goalWeight: goalWeight)
        
        // save entry to new user
        userDBRef?.setValue(FirebaseMappingService.userStateToMap(userState))
        
        // load store
        Store.store.setUserState(userState) // eliminates race conditions inherit by asynchronous call backs from loadUserState
        loadUserState()
    }
    
    func loadUser(_ firAuthUserID:String) {
        let defaults = UserDefaults.standard
        let firDatabaseAutoID = defaults.string(forKey: firAuthUserID)!
        userDBRef = dbref?.child("users").child(firDatabaseAutoID)
        loadUserState()
    }
    
    // load App State
    
    func loadAppState() {
        setDefaultMealPlansListener()
        setDefaultWorkoutsListener()
    }
    
    private func setDefaultMealPlansListener() {
        dbref?.child("meal-plans").observe(DataEventType.value, with: { (mealPlansSnapshot) in
            var mealPlans:[MealPlan] = []
            for mealPlanSnapshot in mealPlansSnapshot.children {
                let mealPlanMap = ((mealPlanSnapshot as! DataSnapshot).value) as! Dictionary<String, Any>
                mealPlans.append(FirebaseMappingService.mapToMealPlan(mealPlanMap))
            }
            Store.store.setDefaultMealPlans(mealPlans)
        })
    }
    
    private func setDefaultWorkoutsListener() {
        dbref!.child("workouts").observe(DataEventType.value, with: { (workoutsSnapshot) in
            var workouts:[Workout] = []
            for workoutSnapshot in workoutsSnapshot.children {
                let workoutMap  = ((workoutSnapshot as! DataSnapshot).value) as! Dictionary<String, Any>
                workouts.append(FirebaseMappingService.mapToWorkout(workoutMap))
            }
            Store.store.setDefaultWorkouts(workouts)
        })
    }
    
    // load User State
    
    func loadUserState() {
        setUserStateListeners()
    }
    
    private func setUserStateListeners() {
        setCurrentMealPlanListener()
    }
    
    private func setCurrentMealPlanListener() {
        userDBRef?.child("currentMealPlan").observe(DataEventType.value, with: { (snapshot) in
            let currentMealPlanMap = snapshot.value as! Dictionary<String, Any>
            Store.store.setCurrentMealPlan(FirebaseMappingService.mapToMealPlan(currentMealPlanMap))
        })
    }
    
    func setCurrentMealPlan(_ mealPlan:MealPlan) {
        userDBRef?.child("currentMealPlan").setValue(FirebaseMappingService.mealPlanToMap(mealPlan))
    }
    
    // unload User State
    
    func unloadUserState() {
        userDBRef = nil
    }
    
}



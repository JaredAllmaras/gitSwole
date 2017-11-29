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
    
    // saves userID to CoreData
    // TODO: Make sure this works when a user log ins
    func createUserDatabase(_ fbUserID:String, _ username:String) {
        print("Creating user in Firebase..")
        userDBRef = dbref?.child("users").childByAutoId()
        
        // save unique childID generated by childByAutoId()
        LocalDataSource.dataSource.saveUser(fbUserID, userDBRef!.key)

//        let breakfast = Meal(calories: 100, firstCourse: Course(), secondCourse: Course(), thirdCourse: Course())
//        let lunch = Meal(calories: 100, firstCourse: , secondCourse: , thirdCourse: )
//        let dinner = Meal(calories: 100, firstCourse: , secondCourse: , thirdCourse: )
//
//        let currentMealPlan = MealPlan(name: "Test...", breakfast: breakfast, lunch: lunch, dinner: dinner)
//        let currentWeight = 170
//        let goalWeight = 150
        
        let currentMealPlan = Store.store.getDefaultMealPlan()
        let currentWeight = 170
        let goalWeight = 150
        
        let userState = UserState(username: username,
                             currentMealPlan: currentMealPlan,
                             currentWeight: currentWeight,
                             goalWeight: goalWeight)
        
        userDBRef?.setValue(userState)
        
        // set up listeners
        setUserStateListeners()
    }
    
    // retrieves the userID from CoreData (must be signed in)
    func configureUserDatabase(_ uid:String) {
        userDBRef = dbref?.child(uid)
        setUserStateListeners()
    }
    
    // load App State
    
    func loadAppState() {
        setAllMealPlansListener()
        setAllWorkoutsListener()
    }
    
    private func setAllMealPlansListener() {
        dbref?.child("meal-plans").observe(DataEventType.value, with: { (mealPlansSnapshot) in
            var mealPlans:[MealPlan] = []
            for mealPlanSnapshot in mealPlansSnapshot.children {
                let mealPlanMap = ((mealPlanSnapshot as! DataSnapshot).value) as! Dictionary<String, Any>
                mealPlans.append(FirebaseMappingService.mapToMealPlan(mealPlanMap))
            }
            Store.store.setDefaultMealPlans(mealPlans)
        })
    }
    
    private func setAllWorkoutsListener() {
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
    
    private func setUserStateListeners() {
        setCurrentMealPlanListener()
    }
    
    func setCurrentMealPlan(_ mealPlan:[String:[String:String]]) {
        userDBRef?.child("currentMealPlan").setValue(mealPlan)
    }
    
    func setCurrentMealPlanListener() {
        userDBRef?.child("currentMealPlan").observe(DataEventType.value, with: { (snapshot) in
            let currentMealPlanMap = snapshot.value as! Dictionary<String, Any>
            Store.store.setCurrentMealPlan(FirebaseMappingService.mapToMealPlan(currentMealPlanMap))
        })
    }
    
}



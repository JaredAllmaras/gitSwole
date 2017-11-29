//
//  AppState.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/23/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

class Store {
    static let store = Store()
    
    private var state:AppState
    
    private init() {
        state = AppState() // Constructs an empty app state
    }
    
    // Getters
    
    public func getDefaultMealPlans() -> Array<MealPlan> {
        return state.defaultMealPlans
    }
    
    public func getDefaultMealPlan() -> MealPlan {
        return state.defaultMealPlans.first!
    }
    
    public func getCurrentMealPlan() -> MealPlan {
        return state.userState.currentMealPlan
    }
    
    public func getDefaultWorkouts() -> Array<Workout> {
        return state.defaultWorkouts
    }
    
    // Setters
    
    public func setCurrentMealPlan(_ newMealPlan:MealPlan) {
//        state = UserState(allMealPlans: state!.allMealPlans, currentMealPlan: newMealPlan)
    }
    
    public func setDefaultMealPlans(_ mealPlans:Array<MealPlan>) {
        let currentWeight = 170
        let goalWeight = 190
        
        let userState = UserState(username: "",
                                  currentMealPlan: mealPlans.first!,
                                  currentWeight: currentWeight,
                                  goalWeight: goalWeight)
        
        state = AppState(defaultMealPlans: mealPlans, defaultWorkouts: state.defaultWorkouts, userState: userState)
    }
    
    public func setDefaultWorkouts(_ workouts:Array<Workout>) {
        state = AppState(defaultMealPlans: state.defaultMealPlans, defaultWorkouts: workouts, userState: state.userState)
    }
}

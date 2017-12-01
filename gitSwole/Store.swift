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
    private var defaultMealPlans:Array<MealPlan>
    
    private init() {
        state = AppState() // Constructs an empty app state
        defaultMealPlans = []
    }
    
    private func defaultUserState() -> UserState {
        let currentWeight = 170
        let goalWeight = 190
        
        return UserState(username: "DefaultUserName",
                         currentMealPlan: defaultMealPlans.first!,
                         currentWeight: currentWeight,
                         goalWeight: goalWeight)
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
    
    public func getUsername() -> String {
        return state.userState.username
    }
    
    // Setters
    
    public func setDefaultMealPlans(_ mealPlans:Array<MealPlan>) {
        defaultMealPlans = mealPlans
        state = AppState(defaultMealPlans: mealPlans, defaultWorkouts: state.defaultWorkouts, userState: defaultUserState())
    }
    
    public func setDefaultWorkouts(_ workouts:Array<Workout>) {
        state = AppState(defaultMealPlans: state.defaultMealPlans, defaultWorkouts: workouts, userState: state.userState)
    }
    
    public func setUserState(_ userState:UserState) {
        state = AppState(defaultMealPlans: state.defaultMealPlans, defaultWorkouts: state.defaultWorkouts, userState: userState)
    }
    
    public func setCurrentMealPlan(_ newMealPlan:MealPlan) {
        let userState = UserState(username: state.userState.username, currentMealPlan: newMealPlan, currentWeight: state.userState.currentWeight, goalWeight: state.userState.goalWeight)
        state = AppState(defaultMealPlans: state.defaultMealPlans, defaultWorkouts: state.defaultWorkouts, userState: userState)
    }
    
    public func unloadUserState() {
        state = AppState(defaultMealPlans: state.defaultMealPlans, defaultWorkouts: state.defaultWorkouts, userState: defaultUserState())
    }
}

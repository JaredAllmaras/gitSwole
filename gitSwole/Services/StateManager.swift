//
//  AppState.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/23/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

protocol AuthStateDelegate {
    func getUser() -> User?
}

class StateManager: AuthStateDelegate {
    
    // MARK: - Fields
    
    // TODO: there should be no persistance for default user
    private var user: User!
    private var popularMealPlans: [MealPlan]
    private var popularWorkouts: [Workout]
    
    // MARK: - Constructors and Configurations
    
    init() {
        user = nil

        popularMealPlans = []
        popularWorkouts = []
    }
    
    func configure() {
        
    }
    
    // MARK: - User
    
    public func getUser() -> User? {
        return user
    }
    
    public func setUser(_ user: User?) {
        self.user = user
    }
    
    public func setDefaultUser() {
        self.user = DefaultUser.user
    }
    
    // MARK: - Meal Plans
    
    public func getPopularMealPlans() -> [MealPlan] {
        return popularMealPlans
    }
    
    public func setPopularMealPlans(_ mealPlans: [MealPlan]) {
        popularMealPlans = mealPlans
    }
    
    public func getMyMealPlans() -> [MealPlan] {
        return user.mealplans
    }
    
    // MARK: - Workouts
    
    public func getPopularWorkouts() -> [Workout] {
        return popularWorkouts
    }
    
    public func setPopularWorkouts(_ workouts: [Workout]) {
        popularWorkouts = workouts
    }
    
    public func getMyWorkouts() -> [Workout] {
        return user.workouts
    }
    
    public func addWorkout(_ workout: Workout) {
        user.workouts.append(workout)
    }
    
    // MARK: - UI State
    
    public func getMyCurrentMealPlan() -> MealPlan {
        return user.mealplans[user!.currentMealPlanIndex]
    }
    
    public func setMyCurrentMealPlan(to index: Int) {
        guard index >= 0 && index < user.mealplans.count else {
            return
        }
        user.currentMealPlanIndex = index
    }
    
    public func getMyCurrentMeal() -> Meal? {
        var currentMeal: Meal?
        switch user.currentMealIndex {
        case 0:
            currentMeal = user.mealplans[user.currentMealPlanIndex].breakfast
        case 1:
            currentMeal = user.mealplans[user.currentMealPlanIndex].lunch
        case 2:
            currentMeal = user.mealplans[user.currentMealPlanIndex].dinner
        default:
            currentMeal = nil
            print("Store: Error: Invalid currentMealIndex")
        }
        return currentMeal
    }
    
    public func setMyCurrentMeal(to index: Int) {
        user.currentMealIndex = index
    }
    
    public func getSelectedMealPlan(at index: Int) -> MealPlan {
        // It's impossible to pick an index that won't be in the list
        return user.mealplans[index]
    }
    
    public func getSelectedWorkout(at index: Int) -> Workout {
        return user.workouts[index]
    }
    
    public func clearUser() {
        user = nil
    }
}














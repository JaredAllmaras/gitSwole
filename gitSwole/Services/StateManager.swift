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
    
    private var user: User?
    private var popularMealPlans: [MealPlan]
    private var popularWorkouts: [Workout]
    
    // TODO: there should be no persistance for default user
    // TODO: put all fields inside a default user
//    private var defaultUser: User?
    private var defaultMealPlans: [MealPlan]
    private var defaultWorkouts: [Workout]
    private var defaultCurrentMealPlanIndex: Int
    private var defaultCurrentMealIndex: Int
    
    private var currentMealPlanIndex: Int // Should be in the user model
    private var currentMealIndex: Int // Should be int the user model
    
    // MARK: - Constructors and Configurations
    
    init() {
        user = nil
        currentMealPlanIndex = 0 // should be in the user model
        currentMealIndex = 0 // should be in the user model
        
        popularMealPlans = []
        popularWorkouts = []
        
        defaultMealPlans = []
        defaultWorkouts = []
        defaultCurrentMealPlanIndex = 0
        defaultCurrentMealIndex = 0
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
    
    // MARK: - Meal Plans
    
    public func getPopularMealPlans() -> [MealPlan] {
        return popularMealPlans
    }
    
    public func setPopularMealPlans(_ mealPlans: [MealPlan]) {
        popularMealPlans = mealPlans
    }
    
    public func getMyMealPlans() -> [MealPlan] {
        if let user = self.user {
            return user.mealplans
        } else {
            return defaultMealPlans
        }
    }
    
    public func setDefaultMealPlans(_ mealPlans: [MealPlan]) {
        defaultMealPlans = mealPlans
    }
    
    // MARK: - Workouts
    
    public func getPopularWorkouts() -> [Workout] {
        return popularWorkouts
    }
    
    public func setPopularWorkouts(_ workouts: [Workout]) {
        popularWorkouts = workouts
    }
    
    public func getMyWorkouts() -> [Workout] {
        if let user = self.user {
            return user.workouts
        } else {
            return defaultWorkouts
        }
    }
    
    public func setDefaultWorkouts(_ workouts: [Workout]) {
        defaultWorkouts = workouts
    }
    
    // MARK: - UI State
    
    public func getMyCurrentMealPlan() -> MealPlan {
        if let user = self.user {
            return user.mealplans[currentMealPlanIndex]
        } else {
            return defaultMealPlans[defaultCurrentMealPlanIndex]
        }
        
    }
    
    public func setMyCurrentMealPlan(to index: Int) {
        if let user = self.user {
            guard index >= 0 && index < user.mealplans.count else {
                return
            }
            currentMealPlanIndex = index
        } else {
            guard index >= 0 && index < defaultMealPlans.count else {
                return
            }
            defaultCurrentMealPlanIndex = index
        }
        
    }
    
    public func getMyCurrentMeal() -> Meal? {
        var currentMeal: Meal?
        if let user = self.user {
            switch currentMealIndex {
            case 0:
                currentMeal = user.mealplans[currentMealPlanIndex].breakfast
            case 1:
                currentMeal = user.mealplans[currentMealPlanIndex].lunch
            case 2:
                currentMeal = user.mealplans[currentMealPlanIndex].dinner
            default:
                currentMeal = nil
                print("Store: Error: Invalid currentMealIndex")
            }
        } else {
            switch defaultCurrentMealIndex {
            case 0:
                currentMeal = defaultMealPlans[defaultCurrentMealPlanIndex].breakfast
            case 1:
                currentMeal = defaultMealPlans[defaultCurrentMealPlanIndex].lunch
            case 2:
                currentMeal = defaultMealPlans[defaultCurrentMealPlanIndex].dinner
            default:
                currentMeal = nil
                print("Store: Error: Invalid defaultCurrentMealIndex")
            }
        }
        return currentMeal
    }
    
    public func setMyCurrentMeal(to index: Int) {
        if let user = self.user {
            currentMealIndex = index
        } else {
            defaultCurrentMealIndex = index
        }
    }
    
    public func getSelectedMealPlan(at index: Int) -> MealPlan {
        // It's impossible to pick an index that won't be in the list
        if let user = self.user {
            return user.mealplans[index]
        } else {
            return defaultMealPlans[index]
        }
    }
    
    public func getSelectedWorkout(at index: Int) -> Workout {
        if let user = self.user {
            return user.workouts[index]
        } else {
            return defaultWorkouts[index]
        }
    }
    
    public func clearUser() {
        user = nil
    }
}

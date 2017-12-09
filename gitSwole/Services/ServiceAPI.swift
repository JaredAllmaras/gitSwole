//
//  ServiceAPI.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 12/9/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

// MARK: - All Service Management

class ServiceAPI {
    
    static let current = ServiceAPI()
    
    private let stateManager = StateManager()
    private let persistanceManager = PersistanceManager()
    private let authManager = AuthManager()
    
    private init() {
        
    }
    
    func configure() {
        stateManager.configure()
        persistanceManager.open(manager: stateManager)
    }
    
}

// MARK: - State Management

extension ServiceAPI {
    
    // MARK: - User
    
    public func getUser() -> User? {
        return stateManager.getUser()
    }
    
    // MARK: - Meal Plans
    
    public func getPopularMealPlans() -> [MealPlan] {
        return stateManager.getPopularMealPlans()
    }
    
    public func setPopularMealPlans(_ mealPlans: [MealPlan]) {
        stateManager.setPopularMealPlans(mealPlans)
    }
    
    public func getMyMealPlans() -> [MealPlan] {
        return stateManager.getMyMealPlans()
    }
    
    // MARK: - Workouts
    
    public func getPopularWorkouts() -> [Workout] {
        return stateManager.getPopularWorkouts()
    }
    
    public func setPopularWorkouts(_ workouts: [Workout]) {
        stateManager.setPopularWorkouts(workouts)
    }
    
    public func getMyWorkouts() -> [Workout] {
        return stateManager.getMyWorkouts()
    }
    
    // MARK: - UI State
    
    public func getMyCurrentMealPlan() -> MealPlan {
        return stateManager.getMyCurrentMealPlan()
    }
    
    public func setMyCurrentMealPlan(to index: Int) {
        stateManager.setMyCurrentMeal(to: index)
    }
    
    public func getMyCurrentMeal() -> Meal? {
        return stateManager.getMyCurrentMeal()
    }
    
    public func setMyCurrentMeal(to index: Int) {
        stateManager.setMyCurrentMeal(to: index)
    }
    
    public func getSelectedMealPlan(at index: Int) -> MealPlan {
        return stateManager.getSelectedMealPlan(at: index)
    }
    
    public func getSelectedWorkout(at index: Int) -> Workout {
        return stateManager.getSelectedWorkout(at: index)
    }
}

// MARK: - Authentication Management

extension ServiceAPI {
    
    public func clearUser() {
        stateManager.clearUser()
    }
}

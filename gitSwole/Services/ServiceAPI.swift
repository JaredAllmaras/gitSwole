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
    
    public func setUser(_ user: User, _ viewController: AuthDelegate) {
        persistanceManager.setUser(user, stateManager, viewController)
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
    
    public func addMealPlan(_ mealPlan: MealPlan) {
        persistanceManager.addMealPlan(mealPlan, numMealPlans: stateManager.getMyMealPlans().count)
        stateManager.addMealPlan(mealPlan)
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
    
    public func addWorkout(_ workout: Workout) {
        persistanceManager.addWorkout(workout, numWorkouts: stateManager.getMyWorkouts().count)
        stateManager.addWorkout(workout)
    }
    
    // MARK: - Progress
    
    public func getMyCurrentWeight() -> Int {
        return stateManager.getMyCurrentWeight()
    }
    
    public func setMyCurrentWeight(_ currentWeight: Int) {
        stateManager.setMyCurrentWeight(currentWeight)
        persistanceManager.setMyCurrentWeight(currentWeight)
    }
    
    public func getMyGoalWeight() -> Int {
        return stateManager.getMyGoalWeight()
    }
    
    public func setMyGoalWeight(_ goalWeight: Int) {
        stateManager.setMyGoalWeight(goalWeight)
        persistanceManager.setMyGoalWeight(goalWeight)
    }
    
    public func getMyCaloricGoal() -> String {
        return stateManager.getMyCaloricGoal()
    }
    
    public func setCaloricGoal(_ caloricGoal: String) {
        stateManager.setMyCaloricGoal(caloricGoal)
        persistanceManager.setCaloricGoal(caloricGoal)
    }
    
    public func getMyCaloricIntake() -> Int {
        return stateManager.getMyCaloricIntake()
    }
    
    public func setCaloricIntake(_ caloricIntake: Int) {
        stateManager.setMyCaloricIntake(caloricIntake)
        persistanceManager.setCaloricIntake(caloricIntake)
    }
    
    // MARK: - UI State
    
    public func getMyCurrentMealPlan() -> MealPlan {
        return stateManager.getMyCurrentMealPlan()
    }
    
    public func setMyCurrentMealPlan(to index: Int) {
        stateManager.setMyCurrentMealPlan(to: index)
        persistanceManager.setMyCurrentMealPlan(to: index)
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
    
    public func signUpToPersistanceManager(_ email: String, _ password: String, _ viewController: AuthDelegate) {
        persistanceManager.signUp(email, password, viewController)
    }
    
    public func signInToPersistanceManager(_ email: String, _ password: String, _ viewController: AuthDelegate) {
        persistanceManager.signIn(email, password, viewController)
    }
    
    public func signOutOfPersistanceManager() {
        persistanceManager.close()
    }
    
    public func isSignedInToPersistanceManager() -> Bool {
        return persistanceManager.isSignedIn()
    }
    
    public func clearUser() {
        stateManager.clearUser()
    }
}

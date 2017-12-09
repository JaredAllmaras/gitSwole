//
//  AppState.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/29/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

/**
 *  AppState models the state of the application at startup
 */
struct AppState {
    
    // MARK: - Fields
    
    let user:User
    let popularMealPlans:Array<MealPlan>
    let popularWorkouts:Array<Workout>
    
    // MARK: - Constructors
    
    init() {
        popularMealPlans = []
        popularWorkouts = []
        user = User()
    }
    
    init(popularMealPlans: [MealPlan], popularWorkouts: [Workout], user: User) {
        self.popularMealPlans = popularMealPlans
        self.popularWorkouts = popularWorkouts
        self.user = user
    }
}

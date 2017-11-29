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
    let defaultMealPlans:Array<MealPlan>
    let defaultWorkouts:Array<Workout>
    let userState:UserState
    init() {
        defaultMealPlans = []
        defaultWorkouts = []
        userState = UserState()
    }
    
    init(defaultMealPlans:Array<MealPlan>, defaultWorkouts:Array<Workout>, userState:UserState) {
        self.defaultMealPlans = defaultMealPlans
        self.defaultWorkouts = defaultWorkouts
        self.userState = userState
    }
}

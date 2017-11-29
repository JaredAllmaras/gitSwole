//
//  State.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/23/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

/**
 *  UserState models the state of the app that is specific to the current user
 */
struct UserState {
    let username:String
    let currentMealPlan:MealPlan
    let currentWeight:Int
    let goalWeight:Int
    init() {
        username = ""
        currentMealPlan = MealPlan()
        currentWeight = 0
        goalWeight = 0
    }
    init(username:String, currentMealPlan:MealPlan, currentWeight:Int, goalWeight:Int) {
        self.username = username
        self.currentMealPlan = currentMealPlan
        self.currentWeight = currentWeight
        self.goalWeight = goalWeight
    }
}

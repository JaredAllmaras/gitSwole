//
//  MealPlan.swift
//  gitSwole
//
//  Created by Nathan Mosley on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

struct MealPlan {
    let name:String
    let breakfast:Meal
    let lunch:Meal
    let dinner:Meal
    init() {
        name = ""
        breakfast = Meal()
        lunch = Meal()
        dinner = Meal()
    }
    init(name:String, breakfast:Meal, lunch:Meal, dinner:Meal) {
        self.name = name
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
}

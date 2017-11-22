//
//  MealPlan.swift
//  gitSwole
//
//  Created by Nathan Mosley on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

class MealPlan {
    
    var Name:String?
    var Meals:[Meal]?
    
    init(name:String, meals:[Meal]) {
        
        self.Name = name
        self.Meals = meals
    }
}

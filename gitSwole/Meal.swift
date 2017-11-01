//
//  Meal.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

class Meal {
    
    var FirstMealItem:String?
    var SecondMealItem:String?
    var ThirdMealItem:String?
    var MealCalories:Int?
    
    init(first:String, second:String, third:String, calories:Int) {
    
        self.FirstMealItem = first
        self.SecondMealItem = second
        self.ThirdMealItem = third
        self.MealCalories = calories
    }
}

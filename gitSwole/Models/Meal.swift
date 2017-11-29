//
//  Meal.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

struct Meal {
    let calories:Int
    let firstCourse:Course
    let secondCourse:Course
    let thirdCourse:Course
    init() {
        calories = 0
        firstCourse = Course()
        secondCourse = Course()
        thirdCourse = Course()
    }
    init(calories:Int, first:Course, second:Course, third:Course) {
        self.calories = calories
        self.firstCourse = first
        self.secondCourse = second
        self.thirdCourse = third
    }
}

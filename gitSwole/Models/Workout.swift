//
//  Workout.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

struct Workout {
    let name:String
    let muscleGroup:String
    let exercises:[Exercise]
    init() {
        name = ""
        muscleGroup = ""
        exercises = []
    }
    init(name:String, muscleGroup:String, exercises:[Exercise]) {
        self.name = name
        self.muscleGroup = muscleGroup
        self.exercises = exercises
    }
}

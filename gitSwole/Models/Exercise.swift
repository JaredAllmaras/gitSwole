//
//  Exercise.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/23/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

struct Exercise {
    let name:String
    let sets:Int
    let reps:Int
    init() {
        name = ""
        sets = 0
        reps = 0
    }
    init(name:String, sets:Int, reps:Int) {
        self.name = name
        self.sets = sets
        self.reps = reps
    }
}

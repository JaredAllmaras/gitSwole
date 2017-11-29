//
//  UserDataModel.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

struct User {
    let username:String
    let currentWeight:Int
    let goalWeight:Int
    init() {
        username = ""
        currentWeight = 0
        goalWeight = 0
    }
    init(username:String, currentWeight:Int, goalWeight:Int) {
        self.username = username
        self.currentWeight = currentWeight
        self.goalWeight = goalWeight
    }
}

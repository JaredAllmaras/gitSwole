//
//  Course.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/29/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

struct Course {
    let name:String
    let servingSize:String // TODO: Change this to an int
    init() {
        name = ""
        servingSize = ""
    }
    init(name:String, servingSize:String) {
        self.name = name;
        self.servingSize = servingSize;
    }
}

//
//  MealPlan.swift
//  gitSwole
//
//  Created by Nathan Mosley on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct MealPlan {
    
    // MARK: - Firebase Metadata
    
    let key:String
    let ref: DatabaseReference?
    
    // MARK: - Fields
    
    let name:String
    let breakfast:Meal
    let lunch:Meal
    let dinner:Meal
    let image:UIImage?
    
    // MARK: - Constructors
    
    init() {
        key = ""
        ref = nil
        
        name = ""
        breakfast = Meal()
        lunch = Meal()
        dinner = Meal()
        
        image = nil
    }
    
    init(name:String, breakfast: Meal, lunch: Meal, dinner: Meal, key:String = "") {
        self.key = key
        self.ref = nil

        self.name = name
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
        
        image = #imageLiteral(resourceName: "mealPlan2Icon")    // See if you can get user to upload personal image
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        let snapshotValue = snapshot.value as! [String:Any]
        name = snapshotValue["name"] as! String
        breakfast = Meal(snapshot: snapshot.childSnapshot(forPath: "breakfast"))
        lunch = Meal(snapshot: snapshot.childSnapshot(forPath: "lunch"))
        dinner = Meal(snapshot: snapshot.childSnapshot(forPath: "dinner"))
        image = #imageLiteral(resourceName: "mealPlan2Icon")
    }
    
    // MARK: - Map
    
    func toMap() -> [String:Any] {
        return [
            "name": name,
            "breakfast": breakfast.toMap(),
            "lunch": lunch.toMap(),
            "dinner": dinner.toMap(),
            // "image": // TODO: finish this
        ]
    }
    
}

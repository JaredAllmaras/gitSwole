//
//  DefaultUser.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 12/9/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

class DefaultUser {
    public static let user: User =
        User(
            username: "",
       currentHeight: 0,
       currentWeight: 0,
          goalWeight: 0,
           mealPlans: defaultMealPlans,
            workouts: defaultWorkouts
          )
    
    
    // MARK: - Default Meal Plans
    
    private static let defaultMealPlans: [MealPlan] = [
        MealPlan(
            name: "Bulking Meal Plan 1",
            breakfast: Meal(
                calories: 809,
                first: Course(name: "Scrambled Whole Egg", servingSize: "3 Large"),
                second: Course(name: "Oatmeal Bowl w/ Yogurt", servingSize: "1 Cup"),
                third: Course(name: "Whole Milk", servingSize: "16 oz")
            ),
            lunch: Meal(
                calories: 445,
                first: Course(name: "Chicken Breast", servingSize: "6 oz"),
                second: Course(name: "Steamed White Rice", servingSize: "1 Cup"),
                third: Course(name: "Broccoli", servingSize: "1 Cup")
            ),
            dinner: Meal(
                calories: 845,
                first: Course(name: "Steak", servingSize: "8 oz"),
                second: Course(name: "Sweet Potato", servingSize: "10 oz"),
                third: Course(name: "Asparagus", servingSize: "1 Cup")
            )
        ),
        MealPlan(
            name: "Cutting Meal Plan 1",
            breakfast: Meal(
                calories: 714,
                first: Course(name: "Bagel with Peanut Butter", servingSize: "2 Tbsp"),
                second: Course(name: "Egg Whites", servingSize: "6 Large"),
                third: Course(name: "Chicken Breast", servingSize: "6 oz")
            ),
            lunch: Meal(
                calories: 591,
                first: Course(name: "Green Vegtables", servingSize: "1 Cup"),
                second: Course(name: "Red Snapper", servingSize: "8 oz"),
                third: Course(name: "White Kidney Beans", servingSize: "1/2 Cup")
            ),
            dinner: Meal(
                calories: 701,
                first: Course(name: "Tuna Sandwich", servingSize: "6 Oz"),
                second: Course(name: "Cooked Quinoa", servingSize: "1/2 Cup"),
                third: Course(name: "Whey Protein Shake", servingSize: "40 g")
            )
        ),
        MealPlan(
            name: "Cutting Meal Plan 2",
            breakfast: Meal(
                calories: 251,
                first: Course(name: "Oatmeal", servingSize: "1/2 Cup"),
                second: Course(name: "Strawberries", servingSize: "1 Cup"),
                third: Course(name: "Egg Whites", servingSize: "6 Large")
            ),
            lunch: Meal(
                calories: 737,
                first: Course(name: "Brown Rice", servingSize: "1 Cup"),
                second: Course(name: "Green Vegetables", servingSize: "1 Cup"),
                third: Course(name: "Chicken Breast", servingSize: "8 oz")
            ),
            dinner: Meal(
                calories: 656,
                first: Course(name: "Leon Steak", servingSize: "6 oz"),
                second: Course(name: "Whey Protein Shake", servingSize: "40 g"),
                third: Course(name: "Cooked Vegetables", servingSize: "1 Cup")
            )
        ),
        MealPlan(
            name: "Cutting Meal Plan 3",
            breakfast: Meal(
                calories: 428,
                first: Course(name: "Scrambled Egg Whites", servingSize: "4 Large"),
                second: Course(name: "Whole-Wheat Toast", servingSize: "2 Slices"),
                third: Course(name: "Greek Yogurt", servingSize: "1 Cup")
            ),
            lunch: Meal(
                calories: 471,
                first: Course(name: "Lean Ground Beef", servingSize: "6 oz"),
                second: Course(name: "Cauliflower", servingSize: "1/2 Cup"),
                third: Course(name: "Brown Rice", servingSize: "1 Cup")
            ),
            dinner: Meal(
                calories: 607,
                first: Course(name: "Tuna Steak", servingSize: "6 oz"),
                second: Course(name: "Sweet Potatoes", servingSize: "2 Cup"),
                third: Course(name: "Brocolli and Asparagus", servingSize: "1 Cup")
            )
        ),
    ]
    
    // MARK: - Default Workouts
    
    private static let defaultWorkouts: [Workout] = [
        Workout(
            name: "Chest",
            muscleGroup: "chest",
            exercises: [
                    Exercise(name: "Bench Press", sets: 4, reps: 10),
                    Exercise(name: "Incline Press", sets: 3, reps: 12),
                    Exercise(name: "Dumbell Flys", sets: 3, reps: 12),
                    Exercise(name: "Pec Deck", sets: 4, reps: 10),
                ]
        ),
        Workout(
            name: "Back",
            muscleGroup: "back",
            exercises: [
                Exercise(name: "Deadlift", sets: 5, reps: 5),
                Exercise(name: "T-Bar Row", sets: 4, reps: 8),
                Exercise(name: "Pullups", sets: 4, reps: 10),
                Exercise(name: "Lat Pulldown", sets: 4, reps: 10),
                ]
        ),
        Workout(
            name: "Legs",
            muscleGroup: "legs",
            exercises: [
                Exercise(name: "Squat", sets: 5, reps: 5),
                Exercise(name: "Standing Calf Raises", sets: 8, reps: 10),
                Exercise(name: "Seated Calf Raises", sets: 4, reps: 15),
                Exercise(name: "Leg Press", sets: 4, reps: 8),
                Exercise(name: "Leg Extensions", sets: 4, reps: 10),
                Exercise(name: "Leg Curls", sets: 4, reps: 10),
                ]
        ),
        Workout(
            name: "Arms",
            muscleGroup: "arms",
            exercises: [
                Exercise(name: "Weighted Dips", sets: 4, reps: 8),
                Exercise(name: "Overhead Tricep", sets: 4, reps: 8),
                Exercise(name: "Tricep Pushdown", sets: 3, reps: 12),
                Exercise(name: "Barbell Curl", sets: 4, reps: 6),
                Exercise(name: "Dumbell Curl", sets: 4, reps: 8),
                Exercise(name: "Hammer Curl", sets: 3, reps: 12),
                ]
        ),
        Workout(
            name: "Shoulders",
            muscleGroup: "shoulders",
            exercises: [
                Exercise(name: "Overhead Press", sets: 4, reps: 8),
                Exercise(name: "Dumbell Shoulder Press", sets: 3, reps: 8),
                Exercise(name: "Lateral Raises", sets: 3, reps: 10),
                Exercise(name: "Cable Raises", sets: 3, reps: 12),
                Exercise(name: "Facepulls", sets: 3, reps: 10),
                Exercise(name: "Reverse Flys", sets: 3, reps: 12),
                ]
        ),
    ]
}

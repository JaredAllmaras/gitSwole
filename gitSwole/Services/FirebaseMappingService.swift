//
//  FirebaseMappingService.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/29/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation

class FirebaseMappingService {
    
    // object to dictionary (writing)
    
    // TODO: Complete Firebase Mapping Service and use it to create a user when a user signs up
    static func userStateToMap(_ userState: UserState) -> Dictionary<String, Any> {
        return
            [
                "username": userState.username,
                "currentMealPlan": mealPlanToMap(userState.currentMealPlan),
                "currentWeight": userState.currentWeight,
                "goalWeight": userState.goalWeight
            ]
    }
    
    
    static func mealPlanToMap(_ mealPlan: MealPlan) -> Dictionary<String, Any> {
        return
            [
                "name": mealPlan.name,
                "breakfast": mealToMap(mealPlan.breakfast),
                "lunch": mealToMap(mealPlan.lunch),
                "dinner": mealToMap(mealPlan.dinner)
            ]
    }
    
    static func mealToMap(_ meal: Meal) -> Dictionary<String, Any> {
        return
            [
                "calories": meal.calories,
                "first-course": courseToMap(meal.firstCourse),
                "second-course": courseToMap(meal.secondCourse),
                "third-course": courseToMap(meal.thirdCourse)
            ]
    }
    
    static func courseToMap(_ course: Course) -> Dictionary<String, String> {
        return
            [
                "name": course.name,
                "serving-size": course.servingSize
            ]
    }
    
    // dictionary to object (reading)
    
    // Meal Plans
    static func mapToMealPlan(_ mealPlanMap:Dictionary<String, Any>) -> MealPlan {
        let name = mealPlanMap["name"] as! String
        let breakfast = mapToMeal(mealPlanMap["breakfast"] as! Dictionary<String, Any>)
        let lunch = mapToMeal(mealPlanMap["lunch"] as! Dictionary<String, Any>)
        let dinner = mapToMeal(mealPlanMap["dinner"] as! Dictionary<String, Any>)
        return MealPlan(name: name, breakfast: breakfast, lunch: lunch, dinner: dinner)
    }
    
    static func mapToMeal(_ mealMap:Dictionary<String, Any>) -> Meal {
        let calories = mealMap["calories"] as! Int
        let firstCourse = mapToCourse(mealMap["first-course"] as! Dictionary<String, String>)
        let secondCourse = mapToCourse(mealMap["second-course"] as! Dictionary<String, String>)
        let thirdCourse = mapToCourse(mealMap["third-course"] as! Dictionary<String, String>)
        return Meal(calories: calories, first: firstCourse, second: secondCourse, third: thirdCourse)
    }
    
    static func mapToCourse(_ courseMap:Dictionary<String, String>) -> Course {
        let name = courseMap["name"]!
        let servingSize = courseMap["serving-size"]!
        return Course(name: name, servingSize: servingSize)
    }
    
    // Workouts
    static func mapToWorkout(_ workoutMap:Dictionary<String, Any>) -> Workout {
        let name = workoutMap["name"] as! String
        let muscleGroup = workoutMap["muscle-group"] as! String
        let exercisesArrayMap = workoutMap["exercises"] as! Array<Dictionary<String, Any>>
        var exercises:Array<Exercise> = []
        for exerciseMap in exercisesArrayMap {
            exercises.append(mapToExercise(exerciseMap))
        }
        return Workout(name: name, muscleGroup: muscleGroup, exercises: exercises)
    }
    
    static func mapToExercise(_ exerciseMap:Dictionary<String, Any>) -> Exercise {
        let name = exerciseMap["name"] as! String
        let sets = exerciseMap["sets"] as! Int
        let reps = exerciseMap["reps"] as! Int
        return Exercise(name: name, sets: sets, reps: reps)
    }
}

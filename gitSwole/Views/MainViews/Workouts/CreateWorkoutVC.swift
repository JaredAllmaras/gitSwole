//
//  CreateWorkoutVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 12/8/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class CreateWorkoutVC: UIViewController {
    
    // MARK: - Properties
    
    var labels:[UILabel]!
    var textFields:[UITextField]!
    var sets:[UITextField]!
    var reps:[UITextField]!
    
    var numExercisesDisplayed:Int = 1
    
    @IBOutlet weak var workoutName: UITextField!
    
    @IBOutlet weak var ex1label: UILabel!
    @IBOutlet weak var ex1text: UITextField!
    @IBOutlet weak var ex2label: UILabel!
    @IBOutlet weak var ex2text: UITextField!
    @IBOutlet weak var ex3label: UILabel!
    @IBOutlet weak var ex3text: UITextField!
    @IBOutlet weak var ex4label: UILabel!
    @IBOutlet weak var ex4text: UITextField!
    @IBOutlet weak var ex5label: UILabel!
    @IBOutlet weak var ex5text: UITextField!
    @IBOutlet weak var ex6label: UILabel!
    @IBOutlet weak var ex6text: UITextField!
    @IBOutlet weak var ex7label: UILabel!
    @IBOutlet weak var ex7text: UITextField!
    @IBOutlet weak var ex8label: UILabel!
    @IBOutlet weak var ex8text: UITextField!
    
    @IBOutlet weak var ex1sets: UITextField!
    @IBOutlet weak var ex1reps: UITextField!
    @IBOutlet weak var ex2sets: UITextField!
    @IBOutlet weak var ex2reps: UITextField!
    @IBOutlet weak var ex3sets: UITextField!
    @IBOutlet weak var ex3reps: UITextField!
    @IBOutlet weak var ex4sets: UITextField!
    @IBOutlet weak var ex4reps: UITextField!
    @IBOutlet weak var ex5sets: UITextField!
    @IBOutlet weak var ex5reps: UITextField!
    @IBOutlet weak var ex6sets: UITextField!
    @IBOutlet weak var ex6reps: UITextField!
    @IBOutlet weak var ex7sets: UITextField!
    @IBOutlet weak var ex7reps: UITextField!
    @IBOutlet weak var ex8sets: UITextField!
    @IBOutlet weak var ex8reps: UITextField!
    
    // MARK: - Actions
    
    @IBAction func addExercise(_ sender: Any) {
        if numExercisesDisplayed < 8 {
            labels[numExercisesDisplayed].isHidden = false
            textFields[numExercisesDisplayed].isHidden = false
            sets[numExercisesDisplayed].isHidden = false
            reps[numExercisesDisplayed].isHidden = false
            numExercisesDisplayed += 1
        } else {
            print("No more exercises can be added!")
        }
    }
    
    @IBAction func saveWorkout(_ sender: Any) {
        
        for i in 0 ... numExercisesDisplayed {
            guard labels[i].text != "" else {
                print("Invalid Input")
                return
            }
        }
    
        var exercises:[Exercise] = []
        var newExercise:Exercise
        
        for i in 0 ... self.numExercisesDisplayed {
            
            if let sets = Int(self.sets[i].text!), let reps = Int(self.reps[i].text!) {
                newExercise = Exercise(name: self.textFields[i].text!, sets: sets, reps: reps)
                exercises.append(newExercise)
            } else {
                print("Invalid Input in Line \(i + 1)")
            }
        }
        
        let newWorkout = Workout(name: self.workoutName.text!, muscleGroup: "", exercises: exercises)
        
        ServiceAPI.current.addWorkout(newWorkout)
    
    }
    
    // MARK: UIViewController LifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        labels = [ex1label, ex2label, ex3label, ex4label, ex5label, ex6label, ex7label, ex8label]
        textFields = [ex1text, ex2text, ex3text, ex4text, ex5text, ex6text, ex7text, ex8text]
        sets = [ex1sets, ex2sets, ex3sets, ex4sets, ex5sets, ex6sets, ex7sets, ex8sets]
        reps = [ex1reps, ex2reps, ex3reps, ex4reps, ex5reps, ex6reps, ex7reps, ex8reps]
        
        for i in numExercisesDisplayed ... self.textFields!.count - 1 {
            self.labels[i].isHidden = true
            self.textFields[i].isHidden = true
            self.sets[i].isHidden = true
            self.reps[i].isHidden = true
        }
        
    }

}

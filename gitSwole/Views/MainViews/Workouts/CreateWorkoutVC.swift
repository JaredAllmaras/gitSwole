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
    
    var exerciseNumberLabels:[UILabel]!
    var nameTextFields:[UITextField]!
    var setTextFields:[UITextField]!
    var repTextFields:[UITextField]!
    
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
    
    @IBOutlet weak var addExerciseButton: UIButton!
    @IBOutlet weak var saveWorkoutButton: UIButton!
    @IBOutlet weak var createWorkoutView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: UIViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createWorkoutView.backgroundColor = Config.primaryLightColor
        createWorkoutView.layer.cornerRadius = 15
        titleLabel.textColor = Config.primaryTextColor
        
        saveWorkoutButton.backgroundColor = Config.buttonBackgroundColor
        saveWorkoutButton.setTitleColor(Config.buttonTextColor, for: .normal)
        saveWorkoutButton.setTitleColor(Config.secondaryDarkColor, for: .disabled)
        saveWorkoutButton.layer.cornerRadius = Config.buttonCornerRadius
        
        addExerciseButton.backgroundColor = Config.buttonBackgroundColor
        addExerciseButton.setTitleColor(Config.buttonTextColor, for: .normal)
        addExerciseButton.setTitleColor(Config.secondaryDarkColor, for: .disabled)
        addExerciseButton.layer.cornerRadius = Config.buttonCornerRadius
        
        exerciseNumberLabels = [ex1label, ex2label, ex3label, ex4label, ex5label, ex6label, ex7label, ex8label]
        nameTextFields = [ex1text, ex2text, ex3text, ex4text, ex5text, ex6text, ex7text, ex8text]
        setTextFields = [ex1sets, ex2sets, ex3sets, ex4sets, ex5sets, ex6sets, ex7sets, ex8sets]
        repTextFields = [ex1reps, ex2reps, ex3reps, ex4reps, ex5reps, ex6reps, ex7reps, ex8reps]
        
        for i in numExercisesDisplayed ... self.nameTextFields!.count - 1 {
            exerciseNumberLabels[i].isHidden = true
            nameTextFields[i].isHidden = true
            setTextFields[i].isHidden = true
            repTextFields[i].isHidden = true
        }
        
    }
    
    // MARK: - Actions
    
    @IBAction func addExercise(_ sender: Any) {
        if numExercisesDisplayed < 8 {
            exerciseNumberLabels[numExercisesDisplayed].isHidden = false
            nameTextFields[numExercisesDisplayed].isHidden = false
            setTextFields[numExercisesDisplayed].isHidden = false
            repTextFields[numExercisesDisplayed].isHidden = false
            numExercisesDisplayed += 1
        } else {
            error("Can't add anymore exercises!")
        }
    }
    
    @IBAction func saveWorkout(_ sender: Any) {
        
        guard workoutName.text != "" else {
            error("Invalid Workout Name")
            return
        }
        
        for i in 0 ..< numExercisesDisplayed {
            guard nameTextFields[i].text != "" else {
                error("Invalid Name for Exercise \(i + 1)")
                return
            }
        }
    
        var exercises:[Exercise] = []
        var newExercise:Exercise
        
        for i in 0 ..< self.numExercisesDisplayed {
            
            if let sets = Int(self.setTextFields[i].text!), let reps = Int(self.repTextFields[i].text!) {
                newExercise = Exercise(name: self.nameTextFields[i].text!, sets: sets, reps: reps)
                exercises.append(newExercise)
            } else {
                error("Invalid Set or Rep in Exercise \(i + 1)")
            }
        }
        
        let newWorkout = Workout(name: self.workoutName.text!, muscleGroup: "", exercises: exercises)
        ServiceAPI.current.addWorkout(newWorkout)
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: UIAlertViewController
    
    private func error(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

}

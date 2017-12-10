//
//  CreateWorkoutVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 12/8/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class CreateWorkoutVC: UIViewController {
    
    var labels:[UILabel]?
    var textFields:[UITextField]?
    var sets:[UITextField]?
    var reps:[UITextField]?
    
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
    
    
    
    @IBAction func addExercise(_ sender: Any) {
        self.numExercisesDisplayed += 1
        self.labels?[numExercisesDisplayed].isHidden = false
        self.textFields?[numExercisesDisplayed].isHidden = false
        self.sets?[numExercisesDisplayed].isHidden = false
        self.reps?[numExercisesDisplayed].isHidden = false
    }
    
    
    @IBAction func saveWorkout(_ sender: Any) {
        
        var invalidInput = false
        
        for i in 0 ... numExercisesDisplayed {
            if (self.labels?[i].text)! == "" {
                invalidInput = true
            }
        }
        if invalidInput == true {
            print ("Invalid input.")
        } else {
        var exercises:[Exercise]?
        var newExercise:Exercise?
        var sets:Int?
        var reps:Int?
        
        for i in 0 ... 	self.numExercisesDisplayed {
            sets = Int((self.sets?[i].text)!)
            reps = Int((self.reps?[i].text)!)
            
            newExercise = Exercise(name: (self.textFields?[i].text)!, sets: sets!, reps: reps!)
            exercises?.append(newExercise!)
        }
        
            let newWorkout = Workout(name: "\(String(describing: self.workoutName.text))", muscleGroup: "", exercises: exercises!)
        // implement database code here to save new workout for user
    
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.labels = [self.ex1label, self.ex2label, self.ex3label, self.ex4label, self.ex5label, self.ex6label, self.ex7label, self.ex8label]
        self.textFields = [self.ex1text, self.ex2text, self.ex3text, self.ex4text, self.ex5text, self.ex6text, self.ex7text, self.ex8text]
        
        for i in numExercisesDisplayed ... (self.textFields?.count)! {
            self.labels?[i].isHidden = true
            self.textFields?[i].isHidden = true
            self.sets?[i].isHidden = true
            self.reps?[i].isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

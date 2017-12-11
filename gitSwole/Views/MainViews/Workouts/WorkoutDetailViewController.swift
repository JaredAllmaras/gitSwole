//
//  WorkoutDetailVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var selectedWorkoutIndex: Int = -1
    var NumExercises:Int?
    
    // TODO: Refactor Timer()
    var timer = Timer()
    var time = 0
    var Checkboxes:[CheckBox]?
    var hours = 0
    var minutes = 0
    var seconds = 0
    var timerString = ""

    @IBOutlet weak var startWorkoutButton: UIButton!
    @IBOutlet weak var WorkoutStatus: UILabel!
    @IBOutlet weak var WorkoutTimer: UILabel!
    
    @IBOutlet weak var workoutNameLabel: UILabel!
    
    @IBOutlet weak var CheckBox1: CheckBox!
    @IBOutlet weak var CheckBox2: CheckBox!
    @IBOutlet weak var CheckBox3: CheckBox!
    @IBOutlet weak var CheckBox4: CheckBox!
    @IBOutlet weak var CheckBox5: CheckBox!
    @IBOutlet weak var CheckBox6: CheckBox!
    @IBOutlet weak var CheckBox7: CheckBox!
    @IBOutlet weak var CheckBox8: CheckBox!
    @IBOutlet weak var firstExerciseLabel: UILabel!
    @IBOutlet weak var secondExerciseLabel: UILabel!
    @IBOutlet weak var thirdExerciseLabel: UILabel!
    @IBOutlet weak var fourthExerciseLabel: UILabel!
    @IBOutlet weak var fifthExerciseLabel: UILabel!
    @IBOutlet weak var sixthExerciseLabel: UILabel!
    
    @IBOutlet weak var seventhExerciseLabel: UILabel!
    @IBOutlet weak var eighthExerciseLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Config.backgroundColor
        
        titleView.backgroundColor = Config.primaryLightColor
        titleView.layer.cornerRadius = 15
        workoutNameLabel.textColor = Config.primaryTextColor
        
        let workout = ServiceAPI.current.getSelectedWorkout(at: selectedWorkoutIndex)
        
        workoutNameLabel.text = workout.name
        
        startWorkoutButton.backgroundColor = Config.buttonBackgroundColor
        startWorkoutButton.setTitleColor(Config.buttonTextColor, for: .normal)
        
        startWorkoutButton.layer.cornerRadius = Config.buttonCornerRadius
        
        self.Checkboxes = [self.CheckBox1, self.CheckBox2, self.CheckBox3, self.CheckBox4, self.CheckBox5, self.CheckBox6, self.CheckBox7, self.CheckBox8]
        self.WorkoutTimer.isHidden = true
        self.NumExercises = workout.exercises.count
        let Labels = [self.firstExerciseLabel, self.secondExerciseLabel, self.thirdExerciseLabel, self.fourthExerciseLabel, self.fifthExerciseLabel, self.sixthExerciseLabel,
            self.seventhExerciseLabel,
            self.eighthExerciseLabel]
        
        for label in Labels {
            label?.isHidden = true
        }
        
        var i = 0
        for exercise in workout.exercises {
            let currentLabel = Labels[i]
            currentLabel?.text = ("\(String(describing: i + 1)): \(exercise.name) - \(exercise.sets) x \(exercise.reps)")
            currentLabel?.isHidden = false
            i += 1
        }
    }
    
    @IBAction func startWorkout(_ sender: Any) {
        
        if self.WorkoutStatus.text == "Workout Not Yet Started" {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerIncrement), userInfo: nil, repeats: true)
       
        for i in 0...(self.NumExercises)! - 1 {
            self.Checkboxes?[i].isHidden = false
        }
        
        self.WorkoutStatus.text = "Workout Started! Time to gitSwole!"
        self.WorkoutTimer.isHidden = false
        }
    }
    
    @objc func timerIncrement () {
        
        time += 1
        (self.hours, self.minutes, self.seconds) = timeConverter(seconds: time)
        if self.hours < 0 {
            self.timerString += "\(String(describing: self.hours)) h \(String(describing: self.minutes)) m \(String(describing: self.seconds)) s"
        } else if minutes > 0 {
            self.timerString += "\(String(describing: self.minutes)) m \(String(describing: self.seconds)) s"
        } else if seconds > 0 {
            self.timerString = "\(String(describing: self.seconds)) s"
        }
    
        self.WorkoutTimer.text = "Time Elapsed: \(self.timerString)"
        self.timerString = ""
        
        var done = true
        for i in 0...((self.NumExercises)! - 1) {
            if (self.Checkboxes?[i].isChecked == false) {
                done = false
            }
        }
        if done {
            self.WorkoutStatus.text = "Workout Complete!"
            self.timer.invalidate()
        }
    }
    
    func timeConverter (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
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

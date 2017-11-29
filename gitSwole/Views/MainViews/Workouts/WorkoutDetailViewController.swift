//
//  WorkoutDetailVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController {
    
    let primaryBackground = UIColor(red: 1.00, green: 0.40, blue: 0.35, alpha: 1.0)
    
    var workout:Workout!
    var NumExercises:Int?
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
    
    
    @IBOutlet weak var CheckBox1: CheckBox!
    @IBOutlet weak var CheckBox2: CheckBox!
    @IBOutlet weak var CheckBox3: CheckBox!
    @IBOutlet weak var CheckBox4: CheckBox!
    @IBOutlet weak var CheckBox5: CheckBox!
    @IBOutlet weak var CheckBox6: CheckBox!
    
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var FirstExercise: UILabel!
    @IBOutlet weak var SecondExercise: UILabel!
    @IBOutlet weak var ThirdExercise: UILabel!
    @IBOutlet weak var FourthExercise: UILabel!
    @IBOutlet weak var FifthExercise: UILabel!
    @IBOutlet weak var SixthExercise: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = primaryBackground
        
        workoutNameLabel.text = workout.name
        
        self.Checkboxes = [self.CheckBox1, self.CheckBox2, self.CheckBox3, self.CheckBox4, self.CheckBox5, self.CheckBox6]
        self.WorkoutTimer.isHidden = true
        self.NumExercises = workout.exercises.count
        let Labels = [self.FirstExercise, self.SecondExercise, self.ThirdExercise, self.FourthExercise, self.FifthExercise, self.SixthExercise]
        
        self.FirstExercise?.isHidden = true
        self.SecondExercise?.isHidden = true
        self.ThirdExercise?.isHidden = true
        self.FourthExercise?.isHidden = true
        self.FifthExercise?.isHidden = true
        self.SixthExercise?.isHidden = true
        
        var i = 0
        for exercise in workout.exercises {
            let currentLabel = Labels[i]
            currentLabel?.text = ("Exercise \(String(describing: i + 1)): \(exercise.name) - \(exercise.sets) x \(exercise.reps)")
            currentLabel?.isHidden = false
            i += 1
        }
    }
    
    @IBAction func startWorkout(_ sender: Any) {
        
        if self.WorkoutStatus.text != "Workout Complete!" {
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

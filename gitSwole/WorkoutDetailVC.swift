//
//  WorkoutDetailVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class WorkoutDetailVC: UIViewController {
    
    let primaryBackground = UIColor(red: 1.00, green: 0.40, blue: 0.35, alpha: 1.0)
    
    var Workout:Workout?

    
    @IBOutlet weak var WorkoutName: UILabel!
    @IBOutlet weak var FirstExercise: UILabel!
    @IBOutlet weak var SecondExercise: UILabel!
    @IBOutlet weak var ThirdExercise: UILabel!
    @IBOutlet weak var FourthExercise: UILabel!
    @IBOutlet weak var FifthExercise: UILabel!
    @IBOutlet weak var SixthExercise: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var Labels = [self.FirstExercise, self.SecondExercise, self.ThirdExercise, self.FourthExercise, self.FifthExercise, self.SixthExercise]
        self.view.backgroundColor = primaryBackground
        
        self.FirstExercise?.isEnabled = false
        self.SecondExercise?.isEnabled = false
        self.ThirdExercise?.isEnabled = false
        self.FourthExercise?.isEnabled = false
        self.FifthExercise?.isEnabled = false
        self.SixthExercise?.isEnabled = false
        
        WorkoutName.text = Workout?.Name
        
        for i in 0...(((self.Workout?.Exercises)?.count)!-1) {
            let currentLabel = Labels[i]
            currentLabel?.text = (self.Workout?.Exercises)?[i]
            currentLabel?.isEnabled = true
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

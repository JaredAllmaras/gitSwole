//
//  CalorieCalculatorVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 11/30/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class CalorieCalculatorVC: UIViewController {

    @IBOutlet weak var sex: UISegmentedControl!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var intake: UILabel!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var goal: UISegmentedControl!
    @IBOutlet weak var activityLevel: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sex.tintColor = Config.buttonBackgroundColor
        self.sex.backgroundColor = Config.backgroundColor
        self.goal.tintColor = Config.buttonBackgroundColor
        self.goal.backgroundColor = Config.backgroundColor
        self.calculateButton.backgroundColor = Config.buttonTextColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This function calculates expected caloric need
    // Not sure if the error checking forumals will work, I
    // know swift is particular about variable types
    @IBAction func calculateCalories(_ sender: Any) {
        
        let ageInput = Int(self.age.text!)
        let heightInput = Int(self.height.text!)
        let weightInput = Int(self.weight.text!)
        let activityLevelInput = Int(self.activityLevel.text!)
        
        if (ageInput != nil && heightInput != nil && weightInput != nil && activityLevelInput != nil) {
        
        var caloricIntake:Float = 66.473
        
        // adjust for sex differences
        if self.sex.selectedSegmentIndex == 0 {
            caloricIntake += 13.7516 / 2.20462 * Float(weightInput!)
            caloricIntake += 5.0033 * 2.54 * Float(heightInput!)
            caloricIntake -= 6.7550 * Float(ageInput!)
        } else {
            caloricIntake = 655.0955
            caloricIntake += 9.5634 / 2.20462 * Float(weightInput!)
            caloricIntake += 1.8496 * 2.54 * Float(heightInput!)
            caloricIntake -= 4.33 * Float(ageInput!)
        }
        // adjust for activity level
        let activityLevel = Float(activityLevelInput!)
        if activityLevel > 20 {
            caloricIntake *= 2.0
        } else {
            caloricIntake *= (1 + (0.05 * activityLevel))
        }
        // adjust for goal
        let caloricGoal = self.goal.selectedSegmentIndex
        if caloricGoal == 0 {
            caloricIntake += 500.0
        } else if caloricGoal == 2{
            caloricIntake -= 500.0
        }
            self.intake.text = "\(String(describing: caloricIntake)) cal."
        
        // Save caloric intake to database here
    }
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

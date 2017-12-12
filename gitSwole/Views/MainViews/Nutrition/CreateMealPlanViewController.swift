//
//  CreateMealPlanViewController.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 12/11/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class CreateMealPlanViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var breakfastLabel: UILabel!
    @IBOutlet weak var lunchLabel: UILabel!
    @IBOutlet weak var dinnerLabel: UILabel!
    
    @IBOutlet weak var breakfastCaloriesTextField: UITextField!
    @IBOutlet weak var breakfastFirstCourseTextField: UITextField!
    @IBOutlet weak var breakfastSecondCourseTextField: UITextField!
    @IBOutlet weak var breakfastThirdCourseTextField: UITextField!
    @IBOutlet weak var breakfastFirstCourseServingSizeTextField: UITextField!
    @IBOutlet weak var breakfastSecondCourseServingSizeTextField: UITextField!
    @IBOutlet weak var breakfastThirdCourseServingSizeTextField: UITextField!
    
    @IBOutlet weak var lunchCaloriesTextField: UITextField!
    @IBOutlet weak var lunchFirstCourseTextField: UITextField!
    @IBOutlet weak var lunchSecondCourseTextField: UITextField!
    @IBOutlet weak var lunchThirdCourseTextField: UITextField!
    @IBOutlet weak var lunchFirstCourseServingSizeTextField: UITextField!
    @IBOutlet weak var lunchSecondCourseServingSizeTextField: UITextField!
    @IBOutlet weak var lunchThirdCourseServingSizeTextField: UITextField!
    
    @IBOutlet weak var dinnerCaloriesTextField: UITextField!
    @IBOutlet weak var dinnerFirstCourseTextField: UITextField!
    @IBOutlet weak var dinnerSecondCourseTextField: UITextField!
    @IBOutlet weak var dinnerThirdCourseTextField: UITextField!
    @IBOutlet weak var dinnerFirstCourseServingSizeTextField: UITextField!
    @IBOutlet weak var dinnerSecondCourseServingSizeTextField: UITextField!
    @IBOutlet weak var dinnerThirdCourseServingSizeTextField: UITextField!

    @IBOutlet weak var createMealPlanButton: UIButton!
    
    // MARK: - UIViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Meal Plan"

        secondView.backgroundColor = Config.primaryLightColor
        secondView.layer.cornerRadius = 15
        
        createMealPlanButton.backgroundColor = Config.buttonBackgroundColor
        createMealPlanButton.setTitleColor(Config.buttonTextColor, for: .normal)
        createMealPlanButton.setTitleColor(Config.secondaryDarkColor, for: .disabled)
        createMealPlanButton.layer.cornerRadius = Config.buttonCornerRadius
        
        lunchLabel.textColor = Config.primaryTextColor
    }

    @IBAction func createMealPlan(_ sender: UIButton) {
        guard validate() else {
            return
        }
        
        let name = nameLabel.text!
        let breakfast = Meal(calories: Int(breakfastCaloriesTextField.text!)!,
                             first: Course(name: breakfastFirstCourseTextField.text!,
                                           servingSize: breakfastFirstCourseServingSizeTextField.text!),
                             second: Course(name: breakfastSecondCourseTextField.text!,
                                            servingSize: breakfastSecondCourseServingSizeTextField.text!),
                             third: Course(name: breakfastThirdCourseTextField.text!,
                                           servingSize: breakfastThirdCourseServingSizeTextField.text!))
        
        let lunch = Meal(calories: Int(lunchCaloriesTextField.text!)!,
                         first: Course(name: lunchFirstCourseTextField.text!,
                                       servingSize: lunchFirstCourseServingSizeTextField.text!),
                         second: Course(name: lunchSecondCourseTextField.text!,
                                        servingSize: lunchSecondCourseServingSizeTextField.text!),
                         third: Course(name: lunchThirdCourseTextField.text!,
                                       servingSize: lunchThirdCourseServingSizeTextField.text!))
        
        let dinner = Meal(calories: Int(dinnerCaloriesTextField.text!)!,
                          first: Course(name: dinnerFirstCourseTextField.text!,
                                        servingSize: dinnerFirstCourseServingSizeTextField.text!),
                          second: Course(name: dinnerSecondCourseTextField.text!,
                                         servingSize: dinnerSecondCourseServingSizeTextField.text!),
                          third: Course(name: dinnerThirdCourseTextField.text!,
                                        servingSize: dinnerThirdCourseServingSizeTextField.text!))
        
        let newMealPlan = MealPlan(name: name, breakfast: breakfast, lunch: lunch, dinner: dinner)
        
        ServiceAPI.current.addMealPlan(newMealPlan)
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Validation
    
    private func validate() -> Bool {
        
        guard nameLabel.text != "" else {
            error("Invalid Name")
            return false
        }
        
        guard breakfastFirstCourseTextField.text != "",
            breakfastSecondCourseTextField.text != "",
            breakfastThirdCourseTextField.text != "",
            breakfastFirstCourseServingSizeTextField.text != "",
            breakfastSecondCourseServingSizeTextField.text != "",
            breakfastThirdCourseServingSizeTextField.text != "",
            Int(breakfastCaloriesTextField.text!) != nil
        else {
            error("Invalid Breakfast")
            return false
        }
        
        guard lunchFirstCourseTextField.text != "",
            lunchSecondCourseTextField.text != "",
            lunchThirdCourseTextField.text != "",
            lunchFirstCourseServingSizeTextField.text != "",
            lunchSecondCourseServingSizeTextField.text != "",
            lunchThirdCourseServingSizeTextField.text != "",
            Int(lunchCaloriesTextField.text!) != nil
            else {
                error("Invalid Lunch")
                return false
        }
        
        guard dinnerFirstCourseTextField.text != "",
            dinnerSecondCourseTextField.text != "",
            dinnerThirdCourseTextField.text != "",
            dinnerFirstCourseServingSizeTextField.text != "",
            dinnerSecondCourseServingSizeTextField.text != "",
            dinnerThirdCourseServingSizeTextField.text != "",
            Int(dinnerCaloriesTextField.text!) != nil
            else {
                error("Invalid Dinner")
                return false
        }
        
        return true
    }
    
    // MARK: - Error
    
    private func error(_ message: String = "Error") {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}

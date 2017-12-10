//
//  MealPlanVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class NutritionViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var calorieCounterButton: UIButton!
    @IBOutlet weak var viewMealPlansButton: UIButton!
    @IBOutlet weak var currentMealTabBar: UISegmentedControl!
    @IBOutlet weak var NextMeal: UILabel!
    @IBOutlet weak var FirstMealItem: UILabel!
    @IBOutlet weak var SecondMealItem: UILabel!
    @IBOutlet weak var ThirdMealItem: UILabel!
    
    @IBOutlet weak var CaloricGoal: UILabel!
    @IBOutlet weak var CaloriesEaten: UILabel!    
    @IBOutlet weak var CaloriesRemaining: UILabel!
    
    // MARK: - UIViewController Lifecycle
    
    // TODO: Decide whether to lazy load values from firebase or not
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Config.backgroundColor
        self.currentMealTabBar.backgroundColor = Config.backgroundColor
        self.currentMealTabBar.tintColor = Config.buttonBackgroundColor
        self.viewMealPlansButton.backgroundColor = Config.buttonBackgroundColor
        self.viewMealPlansButton.setTitleColor(Config.buttonTextColor, for: .normal)
        self.calorieCounterButton.backgroundColor = Config.buttonBackgroundColor
        self.calorieCounterButton.setTitleColor(Config.buttonTextColor, for: .normal)
    }
    
    // TODO: try to utilize the observer pattern to upate labels
    override func viewWillAppear(_ animated: Bool) {
        updateLabels()
    }
    
    // MARK: - Actions

    @IBAction func changeMeal(_ sender: UISegmentedControl) {
        ServiceAPI.current.setMyCurrentMeal(to: sender.selectedSegmentIndex)
        updateLabels()
    }
    
    private func updateLabels() {
        let currentMeal = ServiceAPI.current.getMyCurrentMeal()
        FirstMealItem.text = currentMeal!.firstCourse.name
        SecondMealItem.text = currentMeal!.secondCourse.name
        ThirdMealItem.text = currentMeal!.thirdCourse.name
        
        //        self.NextMeal.text = "Next Meal: Breakfast - \(String(describing: (self.MealPlans?[currentMealPlan].Meals?[0].MealCalories)!)) calories"
        //        self.NextMeal.text = "Next Meal: \(String(describing: sender.titleForSegment(at: sender.selectedSegmentIndex)!)) - \(String(describing: (self.currentMeal?.MealCalories)!)) calories"
    }
    
}

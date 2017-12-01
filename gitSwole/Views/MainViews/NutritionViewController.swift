//
//  MealPlanVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class NutritionViewController: UIViewController {
    
    private var currentMealPlan:MealPlan?
    private var currentMeal:Meal?

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
    
    override func viewWillAppear(_ animated: Bool) {
        currentMealPlan = Store.store.getCurrentMealPlan()
        currentMeal = currentMealPlan?.breakfast
        
        FirstMealItem.text = currentMeal?.firstCourse.name
        SecondMealItem.text = currentMeal?.secondCourse.name
        ThirdMealItem.text = currentMeal?.thirdCourse.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Config.backgroundColor
        self.currentMealTabBar.backgroundColor = Config.backgroundColor
        self.currentMealTabBar.tintColor = Config.buttonBackgroundColor
        self.viewMealPlansButton.backgroundColor = Config.buttonBackgroundColor
        self.viewMealPlansButton.setTitleColor(Config.buttonTextColor, for: .normal)
        self.calorieCounterButton.backgroundColor = Config.buttonBackgroundColor
        self.calorieCounterButton.setTitleColor(Config.buttonTextColor, for: .normal)
        
//        self.NextMeal.text = "Next Meal: Breakfast - \(String(describing: (self.MealPlans?[currentMealPlan].Meals?[0].MealCalories)!)) calories"
        
        // DatabaseService.dataSource.setCurrentMealPlanListener()
    }

    @IBAction func changeMeal(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            currentMeal = currentMealPlan?.breakfast
        case 1:
            currentMeal = currentMealPlan?.lunch
        case 2:
            currentMeal = currentMealPlan?.dinner
        default:
            print("Error: segmented control index is " + String(describing: sender.selectedSegmentIndex))
        }
        
        FirstMealItem.text = currentMeal?.firstCourse.name
        SecondMealItem.text = currentMeal?.secondCourse.name
        ThirdMealItem.text = currentMeal?.thirdCourse.name
        
//        self.NextMeal.text = "Next Meal: \(String(describing: sender.titleForSegment(at: sender.selectedSegmentIndex)!)) - \(String(describing: (self.currentMeal?.MealCalories)!)) calories"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let dsvc = segue.destination as? NutritionTableViewController {
//                dsvc.MealPlans = self.MealPlans
            }
        }
    }
    
}

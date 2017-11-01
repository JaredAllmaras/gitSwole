//
//  MealPlanVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class MealPlanVC: UIViewController {
    
    let primaryBackground = UIColor(red: 1.00, green: 0.40, blue: 0.35, alpha: 1.0)
    
    var currentMeal:Meal?
    var Meals:[Meal]?

    @IBOutlet weak var NextMeal: UILabel!
    @IBOutlet weak var FirstMealItem: UILabel!
    @IBOutlet weak var SecondMealItem: UILabel!
    @IBOutlet weak var ThirdMealItem: UILabel!
    
    @IBOutlet weak var CaloricGoal: UILabel!
    @IBOutlet weak var CaloriesEaten: UILabel!    
    @IBOutlet weak var CaloriesRemaining: UILabel!
    
    func loadMeals(){
        Meals = [Meal(first: "Scrambled Whole Egg - 3 Large", second: "Oatmeal bowl w/ yogurt - 1 cup", third: "Whole milk - 16 oz.", calories: 809),
                 Meal(first:"Chicken Breast - 6oz.", second:"Steamed White Rice - 1 cup", third:"Broccoli - 1 cup", calories: 445),
                 Meal(first:"Steak - 8 oz.", second:"Sweet Potato - 10 oz.", third:"Asparagus - 1 cup", calories: 845)
        ]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = primaryBackground
        
        self.loadMeals()
        
        self.NextMeal.text = "Next Meal: Breakfast - \(String(describing: self.Meals?[0].MealCalories!)) calories"
        self.FirstMealItem.text = Meals?[0].FirstMealItem
        self.SecondMealItem.text = Meals?[0].SecondMealItem
        self.ThirdMealItem.text = Meals?[0].ThirdMealItem
        
        
    }

    @IBAction func changeMeal(_ sender: UISegmentedControl) {
        self.currentMeal = Meals?[sender.selectedSegmentIndex]
        
        self.NextMeal.text = "Next Meal: \(String(describing: sender.titleForSegment(at: sender.selectedSegmentIndex)!)) - \(String(describing:self.currentMeal?.MealCalories!)) calories"
        
        self.FirstMealItem.text = self.currentMeal?.FirstMealItem
        self.SecondMealItem.text = self.currentMeal?.SecondMealItem
        self.ThirdMealItem.text = self.currentMeal?.ThirdMealItem
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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

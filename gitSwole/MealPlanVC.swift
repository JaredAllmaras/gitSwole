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
    var currentMealPlan:Int = 0
    var MealPlans:[MealPlan]?

    @IBOutlet weak var NextMeal: UILabel!
    @IBOutlet weak var FirstMealItem: UILabel!
    @IBOutlet weak var SecondMealItem: UILabel!
    @IBOutlet weak var ThirdMealItem: UILabel!
    
    @IBOutlet weak var CaloricGoal: UILabel!
    @IBOutlet weak var CaloriesEaten: UILabel!    
    @IBOutlet weak var CaloriesRemaining: UILabel!
    
    func loadMealPlans(){
        
        
        
        MealPlans = [
            MealPlan(name: "Bulking Meal Plan 1", meals: [
                Meal(first: "Scrambled Whole Egg - 3 Large", second: "Oatmeal bowl w/ yogurt - 1 cup", third: "Whole milk - 16 oz.", calories: 809),
                Meal(first:"Chicken Breast - 6oz.", second:"Steamed White Rice - 1 cup", third:"Broccoli - 1 cup", calories: 445),
                Meal(first:"Steak - 8 oz.", second:"Sweet Potato - 10 oz.", third:"Asparagus - 1 cup", calories: 845)]),
            MealPlan(name: "Cutting Meal Plan 1", meals:[
                Meal(first: "Bagel with 2 Tbsp. peanut butter", second: "Egg whites - 6 large", third: "Chicken breast - 6oz.", calories: 714),
                Meal(first: "Green Vegetables - 1 cup", second: "Red snapper - 8oz.", third: "White kidney beans - 1/2 cup", calories: 591),
                Meal(first: "Tuna sandwich - 6oz.", second: "Cooked quinoa - 1/2 cup", third: "Whey protein shake - 40g", calories: 701)]),
            MealPlan(name: "Cutting Meal Plan 2", meals:[
                Meal(first: "Oatmeal - 1/2 Cup", second: "Strawberries - 1 cup", third: "Egg whites - 6 large", calories: 251),
                Meal(first: "Brown Rice - 1 cup", second: "Green vegetables - 1 cup", third: "Chicken Breast - 8oz.", calories: 737),
                Meal(first: "Lean steak - 6oz.", second:"Whey Protein shake - 40g", third: "Cooked Vegetables - 1 cup", calories: 656)]),
            MealPlan(name: "Cutting Meal Plan 3", meals:[
                Meal(first: "Scrambled Egg Whites - 4 large", second: "Whole wheat toast - 2 slices", third: "Greek Yogurt - 1 cup", calories: 428),
                Meal(first: "Lean Ground Beef - 6oz.", second: "Cauliflower - 1/2 cup", third: "Brown Rice - 1 cup", calories: 471),
                Meal(first: "Tuna Steak - 6oz.", second:"Sweet Potatoes - 2 cup", third: "Broccoli and Asparagus - 1 cup", calories: 607)])
                ]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = primaryBackground
        
        self.loadMealPlans()
        
        self.NextMeal.text = "Next Meal: Breakfast - \(String(describing: (self.MealPlans?[currentMealPlan].Meals?[0].MealCalories)!)) calories"
        
        DataSource.dataSource.listenToCurrentMeal(FirstMealItem, SecondMealItem, ThirdMealItem)
        
//        self.FirstMealItem.text = MealPlans?[currentMealPlan].Meals?[0].FirstMealItem
//        self.SecondMealItem.text = MealPlans?[currentMealPlan].Meals?[0].SecondMealItem
//        self.ThirdMealItem.text = MealPlans?[currentMealPlan].Meals?[0].ThirdMealItem
        
        
    }

    @IBAction func changeMeal(_ sender: UISegmentedControl) {
        self.currentMeal = MealPlans?[currentMealPlan].Meals?[sender.selectedSegmentIndex]
        
        self.NextMeal.text = "Next Meal: \(String(describing: sender.titleForSegment(at: sender.selectedSegmentIndex)!)) - \(String(describing: (self.currentMeal?.MealCalories)!)) calories"
        
        self.FirstMealItem.text = self.currentMeal?.FirstMealItem
        self.SecondMealItem.text = self.currentMeal?.SecondMealItem
        self.ThirdMealItem.text = self.currentMeal?.ThirdMealItem
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let dsvc = segue.destination as? MealPlansTableViewController {
                dsvc.MealPlans = self.MealPlans
            }
        }
    }
    
}

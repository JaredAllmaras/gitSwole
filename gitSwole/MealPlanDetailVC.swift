//
//  MealPlanDetailVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class MealPlanDetailVC: UIViewController {

    var selectedMealPlanIdx:Int?
    var selectedMealPlan:MealPlan?
    
    
    let primaryBackground = UIColor(red: 1.00, green: 0.40, blue: 0.35, alpha: 1.0)
    
    
    @IBOutlet weak var BreakfastCalories: UILabel!
    @IBOutlet weak var LunchCalories: UILabel!
    @IBOutlet weak var DinnerCalories: UILabel!
    

    @IBOutlet weak var BreakfastFirst: UILabel!
    @IBOutlet weak var BreakfastSecond: UILabel!
    @IBOutlet weak var BreakfastThird: UILabel!
    @IBOutlet weak var LunchFirst: UILabel!
    @IBOutlet weak var LunchSecond: UILabel!
    @IBOutlet weak var LunchThird: UILabel!
    @IBOutlet weak var DinnerFirst: UILabel!
    @IBOutlet weak var DinnerSecond: UILabel!
    @IBOutlet weak var DinnerThird: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = primaryBackground
        
        self.BreakfastCalories.text = "Breakfast - \(String(describing: (self.selectedMealPlan?.Meals?[0].MealCalories)!)) calories"
        self.LunchCalories.text = "Lunch - \(String(describing: (self.selectedMealPlan?.Meals?[1].MealCalories)!)) calories"
        self.DinnerCalories.text = "Dinner - \(String(describing: (self.selectedMealPlan?.Meals?[2].MealCalories)!)) calories"
        
        self.BreakfastFirst.text = self.selectedMealPlan?.Meals?[0].FirstMealItem
        self.BreakfastSecond.text = self.selectedMealPlan?.Meals?[0].SecondMealItem
        self.BreakfastThird.text = self.selectedMealPlan?.Meals?[0].ThirdMealItem
        self.LunchFirst.text = self.selectedMealPlan?.Meals?[1].FirstMealItem
        self.LunchSecond.text = self.selectedMealPlan?.Meals?[1].SecondMealItem
        self.LunchThird.text = self.selectedMealPlan?.Meals?[1].ThirdMealItem
        self.DinnerFirst.text = self.selectedMealPlan?.Meals?[2].FirstMealItem
        self.DinnerSecond.text = self.selectedMealPlan?.Meals?[2].SecondMealItem
        self.DinnerThird.text = self.selectedMealPlan?.Meals?[2].ThirdMealItem

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setCurrentMealPlan(_ sender: Any) {
        DataSource.dataSource.addCurrentMealPlan()
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

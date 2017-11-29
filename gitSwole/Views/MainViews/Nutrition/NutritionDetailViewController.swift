//
//  MealPlanDetailVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class NutritionDetailViewController: UIViewController {

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
        
        self.BreakfastCalories.text = "Breakfast - \(String(describing: (self.selectedMealPlan?.breakfast.calories)!)) calories"
        self.LunchCalories.text = "Lunch - \(String(describing: (self.selectedMealPlan?.lunch.calories)!)) calories"
        self.DinnerCalories.text = "Dinner - \(String(describing: (self.selectedMealPlan?.dinner.calories)!)) calories"
        
        self.BreakfastFirst.text = self.selectedMealPlan?.breakfast.firstCourse.name
        self.BreakfastSecond.text = self.selectedMealPlan?.breakfast.secondCourse.name
        self.BreakfastThird.text = self.selectedMealPlan?.breakfast.thirdCourse.name
        self.LunchFirst.text = self.selectedMealPlan?.lunch.firstCourse.name
        self.LunchSecond.text = self.selectedMealPlan?.lunch.secondCourse.name
        self.LunchThird.text = self.selectedMealPlan?.lunch.thirdCourse.name
        self.DinnerFirst.text = self.selectedMealPlan?.dinner.firstCourse.name
        self.DinnerSecond.text = self.selectedMealPlan?.dinner.secondCourse.name
        self.DinnerThird.text = self.selectedMealPlan?.dinner.thirdCourse.name

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setCurrentMealPlan(_ sender: Any) {
        let mealPlan = ["breakfast": ["first": BreakfastFirst.text!, "second": BreakfastSecond.text!, "third": BreakfastThird.text!],
                        "lunch": ["first": LunchFirst.text!, "second": LunchSecond.text!, "third": LunchThird.text!],
                        "dinner": ["first": DinnerFirst.text!, "second": DinnerSecond.text!, "third": DinnerThird.text!]]
        
        DatabaseService.dataSource.setCurrentMealPlan(mealPlan)
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

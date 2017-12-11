//
//  MealPlanDetailVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class NutritionDetailViewController: UIViewController {

    // MARK: - Properties
    
    var selectedMealPlanIndex:Int!
    
    @IBOutlet weak var breakfastCaloriesLabel: UILabel!
    @IBOutlet weak var lunchCaloriesLabel: UILabel!
    @IBOutlet weak var dinnerCaloriesLabel: UILabel!

    @IBOutlet weak var breakfastFirstCourseLabel: UILabel!
    @IBOutlet weak var breakfastSecondCourseLabel: UILabel!
    @IBOutlet weak var breakfastThirdCourseLabel: UILabel!
    @IBOutlet weak var LunchFirst: UILabel!
    @IBOutlet weak var LunchSecond: UILabel!
    @IBOutlet weak var LunchThird: UILabel!
    @IBOutlet weak var DinnerFirst: UILabel!
    @IBOutlet weak var DinnerSecond: UILabel!
    @IBOutlet weak var DinnerThird: UILabel!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var setCurrentMealPlanButton: UIButton!
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCurrentMealPlanButton.backgroundColor = Config.buttonBackgroundColor
        setCurrentMealPlanButton.setTitleColor(Config.buttonTextColor, for: .normal)
        setCurrentMealPlanButton.layer.cornerRadius = Config.buttonCornerRadius
        
        titleView.backgroundColor = Config.primaryLightColor
        titleView.layer.cornerRadius = 15
        titleLabel.textColor = Config.primaryTextColor
        
        self.view.backgroundColor = Config.backgroundColor
        let selectedMealPlan = ServiceAPI.current.getSelectedMealPlan(at: selectedMealPlanIndex)
        updateLabels(selectedMealPlan)
    }
    
    // MARK: - Actions
    
    @IBAction func setCurrentMealPlan(_ sender: Any) {
        ServiceAPI.current.setMyCurrentMealPlan(to: selectedMealPlanIndex)
    }
    
    // MARK: - Update
    
    func updateLabels(_ selectedMealPlan: MealPlan) {
        
        titleLabel.text = selectedMealPlan.name
        
        self.breakfastCaloriesLabel.text = "Breakfast - \(selectedMealPlan.breakfast.calories) calories"
        self.lunchCaloriesLabel.text = "Lunch - \(selectedMealPlan.lunch.calories) calories"
        self.dinnerCaloriesLabel.text = "Dinner - \(selectedMealPlan.dinner.calories) calories"
        
        self.breakfastFirstCourseLabel.text = selectedMealPlan.breakfast.firstCourse.name
        self.breakfastSecondCourseLabel.text = selectedMealPlan.breakfast.secondCourse.name
        self.breakfastThirdCourseLabel.text = selectedMealPlan.breakfast.thirdCourse.name
        self.LunchFirst.text = selectedMealPlan.lunch.firstCourse.name
        self.LunchSecond.text = selectedMealPlan.lunch.secondCourse.name
        self.LunchThird.text = selectedMealPlan.lunch.thirdCourse.name
        self.DinnerFirst.text = selectedMealPlan.dinner.firstCourse.name
        self.DinnerSecond.text = selectedMealPlan.dinner.secondCourse.name
        self.DinnerThird.text = selectedMealPlan.dinner.thirdCourse.name
    }

}

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
    @IBOutlet weak var firstCourseServingSizeLabel: UILabel!
    @IBOutlet weak var secondCourseServingSizeLabel: UILabel!
    @IBOutlet weak var thirdCourseServingSizeLabel: UILabel!
    
    @IBOutlet weak var caloricGoal: UILabel!
    
    @IBOutlet weak var caloricIntake: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    // MARK: - UIViewController Lifecycle
    
    // TODO: Decide whether to lazy load values from firebase or not
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.backgroundColor = Config.primaryLightColor
        titleView.layer.cornerRadius = 15
        titleLabel.textColor = Config.primaryTextColor
        
        segment.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : Config.secondaryTextColor], for: .selected)
        
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
        let currentMealPlan = ServiceAPI.current.getMyCurrentMealPlan()
        let currentMeal = ServiceAPI.current.getMyCurrentMeal()!
        let userCaloricGoal = ServiceAPI.current.getMyCaloricGoal()
        let userCaloricIntake = ServiceAPI.current.getMyCaloricIntake()
        NextMeal.text = currentMealPlan.name
        FirstMealItem.text = currentMeal.firstCourse.name
        SecondMealItem.text = currentMeal.secondCourse.name
        ThirdMealItem.text = currentMeal.thirdCourse.name
        firstCourseServingSizeLabel.text = currentMeal.firstCourse.servingSize
        secondCourseServingSizeLabel.text = currentMeal.secondCourse.servingSize
        thirdCourseServingSizeLabel.text = currentMeal.thirdCourse.servingSize
        caloricGoal.text = userCaloricGoal
        caloricIntake.text = "\(userCaloricIntake) cal."
    }
    
}

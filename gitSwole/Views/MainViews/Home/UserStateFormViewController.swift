//
//  UserStateFormViewController.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/30/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class UserStateFormViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var currentHeightTextField: UITextField!
    @IBOutlet weak var currentWeightTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var profileErrorLabel: UILabel!
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.layer.cornerRadius = CGFloat(15)
        titleView.backgroundColor = Config.primaryLightColor
        
        titleLabel.textColor = Config.primaryTextColor
        
        usernameTextField.placeholder = "username"
        currentHeightTextField.placeholder = "current height in inches"
        currentWeightTextField.placeholder = "current weight in lbs"
        
        submitButton.backgroundColor = Config.buttonBackgroundColor
        submitButton.setTitleColor(Config.buttonTextColor, for: .normal)
        submitButton.setTitleColor(Config.secondaryDarkColor, for: .disabled)
        submitButton.layer.cornerRadius = Config.buttonCornerRadius
        
        usernameErrorLabel.backgroundColor = Config.primaryDarkColor
        usernameErrorLabel.textColor = Config.primaryTextColor
        usernameErrorLabel.layer.cornerRadius = 5
        usernameErrorLabel.isHidden = true
        
        profileErrorLabel.backgroundColor = Config.primaryDarkColor
        profileErrorLabel.textColor = Config.primaryTextColor
        profileErrorLabel.layer.cornerRadius = 5
        profileErrorLabel.isHidden = true
    }
    
    // MARK: - Actions
    
    @IBAction func submitAction(_ sender: Any) {
        
        if !validUsername() {
            usernameErrorLabel.text = "Invalid Username"
            usernameErrorLabel.isHidden = false
        } else if !validProfileInfo() {
            profileErrorLabel.text = "Weight and Height must be integers"
            profileErrorLabel.isHidden = false
        } else {
            let username = usernameTextField.text!
            let goalWeight = Int(currentHeightTextField.text!)!
            let currentHeight = Int(currentHeightTextField.text!)!
            let currentWeight = Int(currentWeightTextField.text!)!
            
            let user = User(username: username,
                       currentHeight: currentHeight,
                       currentWeight: currentWeight,
                          goalWeight: goalWeight,
                           mealPlans: DefaultUser.user.mealplans,
                            workouts: DefaultUser.user.workouts)
            
            ServiceAPI.current.setUser(user, self)
        }
    }
    
    // MARK: - Validation
    
    private func validProfileInfo() -> Bool {
        let currentHeight = Int(currentHeightTextField.text!)
        let currentWeight = Int(currentWeightTextField.text!)
        return (currentHeight != nil && currentWeight != nil)
    }
    
    private func validUsername() -> Bool {
        let username = usernameTextField.text
        return username != ""
    }

}

extension UserStateFormViewController: AuthDelegate {
    
    // MARK: - AuthDelegate
    
    func proceed() {
        present(MainTabBarController(), animated: true, completion: nil)
    }
    
    func error(_ message: String) {
        print(message)
    }
    
}

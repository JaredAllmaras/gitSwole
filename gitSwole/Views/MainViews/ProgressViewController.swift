//
//  ProgressVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var updateGoalButton: UIButton!
    @IBOutlet weak var goalWeight: UITextField!
    @IBOutlet weak var currentWeight: UITextField!
    
    @IBOutlet weak var goalWeightLabel: UILabel!
    @IBOutlet weak var currentWeightLabel: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.backgroundColor = Config.primaryLightColor
        titleView.layer.cornerRadius = 15
        titleLabel.textColor = Config.primaryTextColor
        
        view.backgroundColor = Config.backgroundColor
        updateGoalButton.backgroundColor = Config.buttonBackgroundColor
        updateGoalButton.setTitleColor(Config.buttonTextColor, for: .normal)
        updateGoalButton.layer.cornerRadius = Config.buttonCornerRadius
    }
    
    // MARK: - Actions
    
    @IBAction func saveGoal(_ sender: Any) {
        
        let intGoal = Int(goalWeight.text!)
        if intGoal == nil {
            print("Invalid goal weight")
            return
        } else {
            goalWeightLabel.text = "\(goalWeight.text!)"
        }
        
        let intCurrent = Int(currentWeight.text!)
        if intCurrent == nil {
            print("Invalid weight")
            return
        } else {
            currentWeightLabel.text = "\(currentWeight.text!)"
        }
        
        difference.text = "\(String(describing: (intGoal! - intCurrent!)))"
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        
        lastUpdated.text = formatter.string(from: date)
    }

}

extension ProgressViewController: UITextFieldDelegate {
    
    // MARK: - UITextFieldDelegate
    
    // This method is called when the user touches the Return key on the
    // keyboard. The 'textField' passed in is a pointer to the textField
    // the cursor was in at the time they touched the Return key on the
    // keyboard.
    //
    // From the Apple documentation: Asks the delegate if the text field
    // should process the pressing of the return button.
    //
    //Code for keyboard dismissal when user touches outside textFields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

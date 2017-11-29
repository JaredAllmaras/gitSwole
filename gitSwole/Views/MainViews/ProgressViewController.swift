//
//  ProgressVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    let primaryBackground = UIColor(red: 1.00, green: 0.40, blue: 0.35, alpha: 1.0)

    @IBOutlet weak var goalWeight: UITextField!
    @IBOutlet weak var currentWeight: UITextField!
    
    @IBOutlet weak var goalWeightLabel: UILabel!
    @IBOutlet weak var currentWeightLabel: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = primaryBackground
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ProgressVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class ProgressVC: UIViewController {
    
    let primaryBackground = UIColor(red: 1.00, green: 0.40, blue: 0.35, alpha: 1.0)

    @IBOutlet weak var goalWeight: UITextField!
    @IBOutlet weak var currentWeight: UITextField!
    
    @IBOutlet weak var goalWeightLabel: UILabel!
    @IBOutlet weak var currentWeightLabel: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    
    @IBAction func saveGoal(_ sender: Any) {
        if currentWeight.text != "" {
            currentWeightLabel.text = "\(currentWeight.text!) lbs"
        }
        if goalWeight.text != "" {
            goalWeightLabel.text = "\(goalWeight.text!) lbs"
        }
        let intGoal:Int = Int(goalWeightLabel.text!)!
        let intCurrent:Int = Int(currentWeightLabel.text!)!
        
        difference.text = "\(String(describing: (intGoal - intCurrent))) lbs"

        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        
        lastUpdated.text = formatter.string(from: date)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = primaryBackground
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

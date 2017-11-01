//
//  ProgressVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class ProgressVC: UIViewController {

    @IBOutlet weak var goalWeight: UITextField!
    @IBOutlet weak var currentWeight: UITextField!
    
    @IBOutlet weak var goalWeightLabel: UILabel!
    @IBOutlet weak var currentWeightLabel: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    
    @IBAction func saveGoal(_ sender: Any) {
        if currentWeight.text != "" {
            currentWeightLabel.text = currentWeight.text
        }
        if goalWeight.text != "" {
            goalWeightLabel.text = goalWeight.text
        }
        /*
        difference.text = Int(goalWeightLabel.text!) - Int(currentWeightLabel.text!)
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

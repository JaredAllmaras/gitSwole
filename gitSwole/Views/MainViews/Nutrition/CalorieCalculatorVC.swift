//
//  CalorieCalculatorVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 11/30/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class CalorieCalculatorVC: UIViewController {

    @IBOutlet weak var sex: UISegmentedControl!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var intake: UILabel!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var goal: UISegmentedControl!
    @IBOutlet weak var activityLevel: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sex.tintColor = Config.buttonBackgroundColor
        self.sex.backgroundColor = Config.backgroundColor
        self.goal.tintColor = Config.buttonBackgroundColor
        self.goal.backgroundColor = Config.backgroundColor
        self.calculateButton.backgroundColor = Config.buttonTextColor
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

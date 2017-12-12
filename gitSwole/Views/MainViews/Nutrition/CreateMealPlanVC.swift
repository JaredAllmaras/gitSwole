//
//  CreateMealPlanVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 12/10/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class CreateMealPlanVC: UIViewController {
    
    var mealItems:[UITextField]?
    var mealPortions:[UITextField]?

    @IBOutlet weak var breakfast1: UITextField!
    @IBOutlet weak var breakfast2: UITextField!
    @IBOutlet weak var breakfast3: UITextField!
    @IBOutlet weak var lunch1: UITextField!
    @IBOutlet weak var lunch2: UITextField!
    @IBOutlet weak var lunch3: UITextField!
    @IBOutlet weak var dinner1: UITextField!
    @IBOutlet weak var dinner2: UITextField!
    @IBOutlet weak var dinner3: UITextField!
    
    @IBOutlet weak var breakfast1Portion: UITextField!
    @IBOutlet weak var breakfast2Portion: UITextField!
    @IBOutlet weak var breakfast3Portion: UITextField!
    @IBOutlet weak var lunch1Portion: UITextField!
    @IBOutlet weak var lunch2Portion: UITextField!
    @IBOutlet weak var lunch3Portion: UITextField!
    @IBOutlet weak var dinner1Portion: UITextField!
    @IBOutlet weak var dinner2Portion: UITextField!
    @IBOutlet weak var dinner3Portion: UITextField!
    
    @IBOutlet weak var saveMealPlanButton: UIButton!
    
    @IBOutlet weak var createMealPlanView: UIView!
    @IBOutlet weak var createMealPlanTitle: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        saveMealPlanButton.backgroundColor = Config.buttonBackgroundColor
        saveMealPlanButton.setTitleColor(Config.buttonTextColor, for: .normal)
        
        createMealPlanView.backgroundColor = Config.primaryColor
        createMealPlanView.layer.cornerRadius = 15
        createMealPlanTitle.textColor = Config.primaryTextColor
        
        self.mealItems = [breakfast1, breakfast2, breakfast3, lunch1, lunch2, lunch3, dinner1, dinner2, dinner3]
        
        self.mealPortions = [breakfast1Portion, breakfast2Portion, breakfast3Portion, lunch1Portion, lunch2Portion, lunch3Portion, dinner1Portion, dinner2Portion, dinner3Portion]
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func saveMealPlan(_ sender: Any) {
        
        // error check that all fields are filled out
        for i in 0 ... ((self.mealItems)?.count)! {
            guard ((self.mealItems)?[i])?.text != "" else {
                error ("Meal Item \(i+1) is invalid.")
                return
            }
            guard ((self.mealPortions)?[i])?.text != "" else {
                error ("Meal Item Portion \(i+1) is invalid.")
                return
                
            }
            }
        
        
        }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private func error(_ message: String) {
        let alert = UIAlertController(title: "Error", message:  message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
    
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

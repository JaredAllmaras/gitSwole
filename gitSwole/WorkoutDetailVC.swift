//
//  WorkoutDetailVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class WorkoutDetailVC: UIViewController {
    
    let primaryBackground = UIColor(red: 1.00, green: 0.40, blue: 0.35, alpha: 1.0)
    
    var Workout:Workout?
    
    @IBOutlet weak var WorkoutName: UILabel!
    @IBOutlet weak var FirstExercise: UILabel!
    @IBOutlet weak var SecondExercise: UILabel!
    @IBOutlet weak var ThirdExercise: UILabel!
    @IBOutlet weak var FourthExercise: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = primaryBackground
        
        WorkoutName.text = Workout?.Name
        FirstExercise.text = Workout?.FirstExercise
        SecondExercise.text = Workout?.SecondExercise
        ThirdExercise.text = Workout?.ThirdExercise
        FourthExercise.text = Workout?.FourthExercise
        
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

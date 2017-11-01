//
//  MainTabBarController.swift
//  gitSwole
//
//  Created by Jared Allmaras on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.tabBar.isTranslucent = false
        
        self.createTabs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func createTabs() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let NathanStoryboard = UIStoryboard(name: "NathanStoryboard",bundle: nil)
        
        //instantiate each view controller
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "settingsVC") as? SettingsViewController
        let MealPlanVC = NathanStoryboard.instantiateViewController(withIdentifier: "MealPlanVC") as? MealPlanVC
        let WorkoutsTVC = NathanStoryboard.instantiateViewController(withIdentifier: "WorkoutsTVC") as? WorkoutsTVC
        
        
        //gets each tab's image (stored in Asets.xcassets)
        let settingsImage = UIImage(named: "SettingsIcon")
        
        //sets tab's attributes
        WorkoutsTVC!.tabBarItem = UITabBarItem(
            title: "Workouts",
            image: nil,
            tag: 2)
        
        MealPlanVC!.tabBarItem = UITabBarItem(
            title: "Nutrition",
            image: nil,
            tag: 3)
        
        settingsVC!.tabBarItem = UITabBarItem(
            title: "Settings",
            image: settingsImage,
            tag: 5)
        
        
        
        //Wrap view controllers in their own nav controllers
        let WorkoutsNav = UINavigationController(rootViewController: WorkoutsTVC!)
        
        let MealPlanNav = UINavigationController(rootViewController: MealPlanVC!)
        
        let settingsNav = UINavigationController(rootViewController: settingsVC!)
        
        
        //Creates an array of controllers that make up the tab bar items.
        let controllers:[UIViewController] = [WorkoutsNav, MealPlanNav, settingsNav]
        self.viewControllers = controllers
        
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

extension MainTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("didSelectItem. item.tag = \(item.tag)")
    }
}

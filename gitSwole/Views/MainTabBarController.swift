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
        self.tabBar.barTintColor = Config.primaryColor
        self.tabBar.tintColor = Config.primaryTextColor
        self.tabBar.unselectedItemTintColor = Config.secondaryColor
        
        self.createTabs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func createTabs() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let NathanStoryboard = UIStoryboard(name: "NathanStoryboard",bundle: nil)
        
        //instantiate each view controller
        let MediaPlayerVC = storyboard.instantiateViewController(withIdentifier: "PlaylistVC") as? PlaylistViewController
        let MealPlanVC = NathanStoryboard.instantiateViewController(withIdentifier: "MealPlanVC") as? NutritionViewController
        let WorkoutsTVC = NathanStoryboard.instantiateViewController(withIdentifier: "WorkoutsTVC") as? WorkoutsTableViewController
        let ProgressVC = NathanStoryboard.instantiateViewController(withIdentifier: "ProgressVC") as? ProgressViewController
        let HomeVC = NathanStoryboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController
        
        
        //sets tab's attributes
        HomeVC!.tabBarItem = UITabBarItem(
            title: "Home",
            image: #imageLiteral(resourceName: "houseIcon"),
            tag: 1)
        
        WorkoutsTVC!.tabBarItem = UITabBarItem(
            title: "Workouts",
            image: #imageLiteral(resourceName: "weightIcon"),
            tag: 2)
        
        MealPlanVC!.tabBarItem = UITabBarItem(
            title: "Nutrition",
            image: #imageLiteral(resourceName: "porkChopIcon"),
            tag: 3)
        
        ProgressVC!.tabBarItem = UITabBarItem(
            title: "Progress",
            image: #imageLiteral(resourceName: "progress-icon"),
            tag: 4)
        
        MediaPlayerVC!.tabBarItem = UITabBarItem(
            title: "Music",
            image: #imageLiteral(resourceName: "smallPlay"),
            tag: 5)
        
        
        //Wrap view controllers in their own nav controllers
        let WorkoutsNav = UINavigationController(rootViewController: WorkoutsTVC!)
        let MealPlanNav = UINavigationController(rootViewController: MealPlanVC!)
        let MediaPlayerNav = UINavigationController(rootViewController: MediaPlayerVC!)
        let ProgressNav = UINavigationController(rootViewController: ProgressVC!)
        let HomeNav = UINavigationController(rootViewController: HomeVC!)
        
        //Creates an array of controllers that make up the tab bar items.
        let controllers:[UIViewController] = [HomeNav, WorkoutsNav, MealPlanNav, ProgressNav, MediaPlayerNav]
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

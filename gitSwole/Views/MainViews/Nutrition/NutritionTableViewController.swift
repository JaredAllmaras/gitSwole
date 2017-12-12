//
//  MealPlansTableViewController.swift
//  gitSwole
//
//  Created by Nathan Mosley on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class NutritionTableViewController: UITableViewController {
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = Config.backgroundColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Meal Plan", style: .plain, target: self, action: #selector(addMealPlan))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mealPlans = ServiceAPI.current.getMyMealPlans()
        return mealPlans.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealPlanCell", for: indexPath) as! NutritionTableViewCell
        
        let mealPlans = ServiceAPI.current.getMyMealPlans()
        // TODO: Add mealPlans image
        cell.MealPlanName.text = mealPlans[indexPath.row].name
        cell.backgroundColor = Config.backgroundColor

        return cell
    }
    
    // MARK: - Add Meal Plan
    
    @objc func addMealPlan() {
        let storyboard = UIStoryboard(name: "NathanStoryboard", bundle: nil)
        let createMealPlanViewController = storyboard.instantiateViewController(withIdentifier: "CreateMealPlanVC")
        navigationController?.pushViewController(createMealPlanViewController, animated: true)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let dsvc = segue.destination as? NutritionDetailViewController {
                dsvc.selectedMealPlanIndex = tableView.indexPathForSelectedRow!.row
            }
        }
    }

}

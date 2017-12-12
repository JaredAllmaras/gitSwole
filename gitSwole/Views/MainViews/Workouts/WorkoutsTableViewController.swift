//
//  WorkoutsTVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class WorkoutsTableViewController: UITableViewController {
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = Config.backgroundColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Workout", style: .plain, target: self, action: #selector(addWorkout))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - UITableViewController DataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let workouts = ServiceAPI.current.getMyWorkouts()
        return workouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! WorkoutCell
        
        let workouts = ServiceAPI.current.getMyWorkouts()
        let currentWorkout = workouts[indexPath.row]

        cell.workoutNameLabel.text = currentWorkout.name
        cell.backgroundColor = Config.backgroundColor
        
        return cell
    }
    
    // MARK: - Add Workout
    
    @objc func addWorkout() {
        let storyboard = UIStoryboard(name: "NathanStoryboard", bundle: nil)
        let createWorkoutViewController = storyboard.instantiateViewController(withIdentifier: "CreateWorkoutVC")
        navigationController?.pushViewController(createWorkoutViewController, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let dsvc = segue.destination as? WorkoutDetailViewController {
                let selectedIndex = tableView.indexPathForSelectedRow
                dsvc.selectedWorkoutIndex = selectedIndex!.row
            }
        }
    }
}

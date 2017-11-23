//
//  WorkoutsTVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class WorkoutsTVC: UITableViewController {
    
    var Workouts:[Workout]?
    let primaryBackground = UIColor(red: 1.00, green: 0.40, blue: 0.35, alpha: 1.0)
    
    func loadWorkouts() {
        
        self.Workouts = [
            Workout(name:"Chest", exercises:["Bench Press - 4x10", "Incline Press - 3x12", "Dumbell Flyes - 3x12", "Pec Deck - 4x10"]),
            Workout(name: "Back", exercises:["Deadlift - 5x5", "T-bar Row - 4x8", "Pullups - 4x10", "Lat Pulldown - 3x10", "Seated Cable Row - 3x10", "Shrug - 4x10"]),
            Workout(name: "Legs", exercises:["Squat - 5x5", "Standing Calf Raise - 8x10", "Seated Calf Machine - 4x15", "Leg Press - 4x8", "Leg Extensions - 4x10", "Leg Curls - 4x10"]),
            Workout(name: "Arms", exercises: ["Weighted Dips - 4x8", "Overhead Tricep Ext. - 4x8", "Tricep Pushdown - 3x12", "Barbell Curl - 4x6", "Dumbbell Curl - 4x8", "Hammer Curl - 3x12"]),
            Workout(name: "Shoulders", exercises:["Overhead Press - 4x8", "Dbell Shoulder Press - 3x8", "Lateral Raises - 3x10", "Cable Raises - 3x12", "Facepulls - 3x10", "Reverse Flyes - 3x12"])
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = primaryBackground
        
        self.loadWorkouts()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (Workouts?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! WorkoutCell
        let currentWorkout = self.Workouts?[indexPath.row]

        cell.WorkoutName.text = currentWorkout?.Name
        cell.backgroundColor = self.primaryBackground
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let dsvc = segue.destination as? WorkoutDetailVC {
                let selectedIndex = tableView.indexPathForSelectedRow
                dsvc.Workout = self.Workouts?[(selectedIndex?.row)!]
            }
    }

    }
}

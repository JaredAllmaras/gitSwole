//
//  localDataSource.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseAuth
import CoreData
import UIKit

class LocalDataSource {
    static let dataSource = LocalDataSource()
    
    var viewContext:NSManagedObjectContext?
    var appDelegate:AppDelegate?
    
    init() {
        viewContext = nil
        appDelegate = nil
    }
    
    func configure() {
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        viewContext = appDelegate?.persistentContainer.viewContext
    }
    
    func setUser(user: FirebaseAuth.User) {
        let newUser = User(context: viewContext!)
        user.getIDToken(completion: { (id, error) in
            if error == nil {
                newUser.id = id
                self.appDelegate?.saveContext()
            } else {
                print("Error: Unable to fetch ID")
            }
        })
    }
    
    func getUser() -> String? {
//        let usersFetch:NSFetchRequest<User> = NSFetchRequest(entityName: "User")
//        usersFetch.predicate = NSPredicate(format: "", )
//        
//        do {
//            let fetchedUsers = try viewContext?.fetch(usersFetch)
//        } catch {
//            print("Error: Unable to fetch User from CoreData")
//            return nil
//        }
        return nil
    }
}

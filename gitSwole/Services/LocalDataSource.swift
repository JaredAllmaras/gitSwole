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

    func saveUser(_ fbUserID:String, _ userID:String) {
        let newUser = LocalUser(context: viewContext!)
        newUser.userRefID = userID
        newUser.firebaseID = fbUserID
        
        appDelegate?.saveContext()
    }
    
//    func getUserID() -> String? {
//        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
//        let fbID = UserService.user.getUserFBID()
//        guard fbID != nil else {
//            print("Error: fbID is nil")
//            return nil
//        }
//        userFetchRequest.predicate = NSPredicate(format: "fbID == %@", fbID!)
//
//        do {
//            let fetchedUsers = try viewContext?.fetch(userFetchRequest)
//            return fetchedUsers?.first?.id
//        } catch {
//            print("Error: Unable to fetch User from CoreData")
//            return nil
//        }
//    }
}

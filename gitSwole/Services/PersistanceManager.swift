//
//  DataSource.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/21/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

/**
 *  FirebaseDatabaseReference wrapper (singleton object)
 */
class PersistanceManager {
    
    // MARK: - Properties
    private var dbref: DatabaseReference?
    private var userDBRef: DatabaseReference?

    init() {}
    
    // MARK: User
    
    private func fetchUser(state: StateManager, user: FirebaseAuth.User, viewController: AuthDelegate?) {
        print("Info: Fetching user with key: ...")
        
        userDBRef!.observe(.value) { (userSnapshot: DataSnapshot) in
            state.setUser(User(user: user, snapshot: userSnapshot))
            viewController?.proceed()
        }
    }
    
    func setUser(_ user: User, _ state: StateManager, _ viewController: AuthDelegate) {
        print("Info: Creating user in Firebase..")

        // generate new user in database
        userDBRef = dbref?.child("users").childByAutoId()

        // grab FIRAuthUserID from AuthService
        let firAuthUserID = Auth.auth().currentUser!.uid
        print("firAuthUserID: " + firAuthUserID)

        // save key-value pair [firAuthUserID: FIRDatabaseAutoID] to local storage
        let firDatabaseAutoID = userDBRef!.key
        let defaults = UserDefaults.standard
        defaults.set(firDatabaseAutoID, forKey: firAuthUserID)

        // write user to database
        userDBRef!.setValue(user.toMap())

        // load store
        fetchUser(state: state, user: Auth.auth().currentUser!, viewController: viewController)
    }
    
    // MARK: Meal Plans
    func addMealPlan(_ mealPlan: MealPlan, numMealPlans: Int) {
        userDBRef?.child("meal-plans/\(numMealPlans)").setValue(mealPlan.toMap())
    }
    
    // MARK: Workouts
    
    func addWorkout(_ workout: Workout, numWorkouts: Int) {
        userDBRef?.child("workouts/\(numWorkouts)").setValue(workout.toMap())
    }
    
    // MARK: - UI State
    
    func setMyCurrentMealPlan(to index: Int) {
        userDBRef?.child("current-meal-plan-index").setValue(index)
    }
    
    private func fetchDefaults(state: StateManager) {
        print("Info: Fetching Defaults")
        
        dbref!.child("default-user").observe(.value) { (defaultUserSnapshot) in
            state.setUser(User(user: nil, snapshot: defaultUserSnapshot))
        }
    }
}

extension PersistanceManager {
    
    // MARK: - Open
    
    func open(manager state: StateManager) {
        
        dbref = Database.database().reference().child("app")
        
        Auth.auth().addStateDidChangeListener { (auth, firebaseUser) in
            
            let localUser = state.getUser()
            
            // Case 1: User is not signed in (firebaseUser == nil && localUser == nil)
            // load defaults
            if (firebaseUser == nil && localUser?.id == nil) {
//                self.fetchDefaults(state: state)
                state.setDefaultUser()
            }
                // Case 2: User is signed in locally but not in firebase (firebaseUser == nil && localUser == A)
                // load defaults
                // set user to nil
            else if firebaseUser == nil && localUser?.id != nil {
//                state.setUser(nil)
                state.setDefaultUser()
//                self.fetchDefaults(state: state)
            }
                // Case 3: User is signed in on firebase but not locally (firebaseUser == A && localUser == nil)
                //      Means that they just signed in or signed up
                // load user from firebase database
            else if firebaseUser != nil && localUser?.id == nil {
                let defaults = UserDefaults.standard
                let firDatabaseAutoID = defaults.string(forKey: Auth.auth().currentUser!.uid)
                if let autoID = firDatabaseAutoID {
                    // if user exists in the database (user is signing in) fetch user
                    self.userDBRef = self.dbref!.child("users").child(autoID)
                    self.fetchUser(state: state, user: firebaseUser!, viewController: nil)
                } else {
                    // user does not exist in the database (user is signing up) don't load anything
                    // The user will be loaded once he fills out the user form
                }
            }
            else if let user1 = firebaseUser, let user2ID = localUser?.id {
                
                // Case 4: (firebaseUser == A && localUser == B)
                // load defaults
                // signout of firebase
                // set user to nil
                if user1.uid != user2ID {
//                    self.fetchDefaults(state: state)
                    state.setDefaultUser()
                    self.close()
                }
                    
                // Case 5: (firebaseUser == A && localUser == A)
                // load user from firebase
                else {
                    let defaults = UserDefaults.standard
                    if let firDatabaseAutoID = defaults.string(forKey: user2ID) {
                        self.userDBRef = self.dbref!.child("users/\(firDatabaseAutoID)")
                        self.fetchUser(state: state, user: user1, viewController: nil)
                    }
                }
            }
        }
    }
    
    // MARK: - Close
    
    func close() {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Authentication
    
    func signUp(_ email:String, _ password:String, _ viewController: AuthDelegate) {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                viewController.proceed()
            } else {
                print(error!.localizedDescription)
                var errorMessage:String
                switch (error!.localizedDescription) {
                case "The email address is already in use by another account.":
                    errorMessage = "This email address is already in use"
                case "The password must be 6 characters long or more.":
                    errorMessage = "Password must be > 6 characters"
                default:
                    errorMessage = "Oops! Something went wrong."
                }
                
                viewController.error(errorMessage)
            }
        })
    }
    
    func signIn(_ email: String, _ password: String, _ viewController: AuthDelegate) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                print(user?.displayName)
                viewController.proceed()
            } else {
                print(error!.localizedDescription)
                var errorString:String
                switch error!.localizedDescription {
                case "The password is invalid or the user does not have a password.":
                    errorString = "Invalid password"
                default:
                    errorString = "Oops! Something went wrong."
                }
                viewController.error(errorString)
            }
        })
    }
    
    func isSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}

//
//    func createAndLoadUser(_ userState:UserState, _ viewController:SignUpProtocol) {
//        print("Creating user in Firebase..")
//
//        // generate new user in database
//        userDBRef = dbref?.child("users").childByAutoId()
//
//        // grab FIRAuthUserID from AuthService
//        let firAuthUserID = AuthService.user.getUserID()
//        print("firAuthUserID: " + firAuthUserID)
//
//        // save key-value pair [firAuthUserID: FIRDatabaseAutoID] to local storage
//        let firDatabaseAutoID = userDBRef!.key
//        let defaults = UserDefaults.standard
//        defaults.set(firDatabaseAutoID, forKey: firAuthUserID)
//
//        // save userState to new user
//        userDBRef?.setValue(FirebaseMappingService.userStateToMap(userState))
//
//        // load store
////        Store.store.setUserState(userState) // eliminates race conditions inherit by asynchronous call backs from loadUserState
//        loadUserState(viewController)
//    }
//
////    func createAndLoadUser(_ firAuthUserID:String) {
////        print("Creating user in Firebase..")
////
////        // generate new user in database
////        userDBRef = dbref?.child("users").childByAutoId()
////
////        // save key-value pair [firAuthUserID: FIRDatabaseAutoID] to local storage
////        let firDatabaseAutoID = userDBRef!.key
////        let defaults = UserDefaults.standard
////        defaults.set(firDatabaseAutoID, forKey: firAuthUserID)
////
////        // create user entry
////        let currentMealPlan = Store.store.getDefaultMealPlan()
////        let username = ""
////        let currentWeight = 170
////        let goalWeight = 150
////
////        let userState = UserState(username: username,
////                             currentMealPlan: currentMealPlan,
////                             currentWeight: currentWeight,
////                             goalWeight: goalWeight)
////
////        // save entry to new user
////        userDBRef?.setValue(FirebaseMappingService.userStateToMap(userState))
////
////        // load store
////        Store.store.setUserState(userState) // eliminates race conditions inherit by asynchronous call backs from loadUserState
////        loadUserState()
////    }
//
//    func loadUser(_ firAuthUserID:String, _ viewController:SignUpProtocol) {
//        let defaults = UserDefaults.standard
//        let firDatabaseAutoID = defaults.string(forKey: firAuthUserID)!
//        userDBRef = dbref?.child("users").child(firDatabaseAutoID)
//        loadUserState(viewController)
//    }
//
//    // load App State
//
//    func loadAppState() {
//        setDefaultMealPlansListener()
//        setDefaultWorkoutsListener()
//    }
//
//    private func setDefaultMealPlansListener() {
//        dbref?.child("meal-plans").observe(DataEventType.value, with: { (mealPlansSnapshot) in
//            var mealPlans:[MealPlan] = []
//            for mealPlanSnapshot in mealPlansSnapshot.children {
//                let mealPlanMap = ((mealPlanSnapshot as! DataSnapshot).value) as! Dictionary<String, Any>
//                mealPlans.append(FirebaseMappingService.mapToMealPlan(mealPlanMap))
//            }
//            ServiceAPI.current.setDefaultMealPlans(mealPlans)
//            self.defaultMealPlansDone = true
//        })
//    }
//
//    private func setDefaultWorkoutsListener() {
//        dbref!.child("workouts").observe(DataEventType.value, with: { (workoutsSnapshot) in
//            var workouts:[Workout] = []
//            for workoutSnapshot in workoutsSnapshot.children {
//                let workoutMap  = ((workoutSnapshot as! DataSnapshot).value) as! Dictionary<String, Any>
//                workouts.append(FirebaseMappingService.mapToWorkout(workoutMap))
//            }
//            ServiceAPI.current.setDefaultWorkouts(workouts)
//            self.defaultWorkoutsDone = true
//        })
//    }
//
//    // load User State
//
//    func loadUserState(_ viewController:SignUpProtocol) {
//        userDBRef?.observe(DataEventType.value, with: { (userStateSnapshot) in
//            let userStateMap = userStateSnapshot.value as! Dictionary<String, Any>
//            ServiceAPI.current.setUserState(FirebaseMappingService.mapToUserState(userStateMap))
//            viewController.proceed()
//        })
//    }
//
////    private func setCurrentMealPlanListener() {
////        userDBRef?.child("currentMealPlan").observe(DataEventType.value, with: { (snapshot) in
////            let currentMealPlanMap = snapshot.value as! Dictionary<String, Any>
////            Store.store.setCurrentMealPlan(FirebaseMappingService.mapToMealPlan(currentMealPlanMap))
////        })
////    }
//
//    func setCurrentMealPlan(_ mealPlan:MealPlan) {
//        userDBRef?.child("currentMealPlan").setValue(FirebaseMappingService.mealPlanToMap(mealPlan))
//    }
//
//    // unload User State
//
//    func unloadUserState() {
//        userDBRef = nil
//    }



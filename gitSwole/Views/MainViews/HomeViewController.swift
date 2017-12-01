//
//  HomeVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var backgroundSubView: UIView!
    @IBOutlet weak var popularWorkoutsCollectionView: UICollectionView!
    @IBOutlet weak var popularMealPlansCollectionView: UICollectionView!
    
    @IBOutlet weak var popularWorkoutsLabel: UILabel!
    @IBOutlet weak var popularMealPlansLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var popularWorkoutImages = [UIImage(named: "workout1Icon"), UIImage(named: "workout2Icon"), UIImage(named: "workout3Icon"), UIImage(named: "workout1Icon"), UIImage(named: "workout2Icon"), UIImage(named: "workout3Icon")]
    
    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    var player: SPTAudioStreamingController?
    var loginUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "gitSwole"
        
        let delegate = PopularMealPlansDelegate()
        popularMealPlansCollectionView.delegate = delegate
        popularMealPlansCollectionView.dataSource = delegate
        
        self.view.backgroundColor = Config.backgroundColor
        backgroundSubView.layer.cornerRadius = 15
        backgroundSubView.backgroundColor = Config.primaryLightColor
    
        signUpButton.backgroundColor = Config.buttonBackgroundColor
        signUpButton.setTitleColor(Config.buttonTextColor, for: .normal)
        signUpButton.setTitleColor(Config.secondaryDarkColor, for: .disabled)
        signUpButton.layer.cornerRadius = Config.buttonCornerRadius
        
        loginButton.backgroundColor = Config.buttonBackgroundColor
        loginButton.setTitleColor(Config.buttonTextColor, for: .normal)
        loginButton.setTitleColor(Config.secondaryDarkColor, for: .disabled)
        loginButton.layer.cornerRadius = Config.buttonCornerRadius
        
        logoutButton.backgroundColor = Config.buttonBackgroundColor
        logoutButton.setTitleColor(Config.buttonTextColor, for: .normal)
        logoutButton.setTitleColor(Config.secondaryDarkColor, for: .disabled)
        logoutButton.layer.cornerRadius = Config.buttonCornerRadius
        
        popularWorkoutsCollectionView.backgroundColor = Config.primaryLightColor
        popularMealPlansCollectionView.backgroundColor = Config.primaryLightColor
        
        popularWorkoutsLabel.textColor = Config.primaryTextColor
        popularMealPlansLabel.textColor = Config.primaryTextColor
        
//        let popularMealPlans = Store.store.getDefaultMealPlans()
//        let mealPlanView = UIView(frame: CGRect(x: 8, y: 8, width: 180, height: 300))
//        mealPlanView.backgroundColor = Config.secondaryColor
//        popularMealPlansScrollView.addSubview(mealPlanView)
//        popularMealPlansScrollView.backgroundColor = Config.primaryLightColor
//
//        let popularWorkouts = Store.store.getDefaultWorkouts()
//
//        let width = 5
//        var startX = 0
//        for _ in 0...5 {
//            let workoutView = UIView(frame: CGRect(x: startX + 8, y: 8, width: width, height: 300))
//            popularWorkoutsScrollView.addSubview(workoutView)
//            print(startX)
//            startX += (width + 8)
//        }
//        popularWorkoutsScrollView.backgroundColor = Config.primaryLightColor
        
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.updateAfterFirstLogin), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        enableDisableButtons()
//        if AuthService.user.signedIn() {
//            titleLabel.text = "Welcome, " + Store.store.getUsername()
//        } else {
//            titleLabel.text = "gitSwole"
//        }
    }
    
    func enableDisableButtons() {
        if AuthService.user.signedIn() {
            signUpButton.isEnabled = false
            loginButton.isEnabled = false
            logoutButton.isEnabled = true
        } else {
            signUpButton.isEnabled = true
            loginButton.isEnabled = true
            logoutButton.isEnabled = false
        }
    }
    
    
    @objc func updateAfterFirstLogin() {
        let userDefaults = UserDefaults.standard
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            
            self.session = firstTimeSession
            initializePlayer(authSession: session)
        }
    }
    
    func initializePlayer(authSession: SPTSession) {
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            try! player!.start(withClientId: auth.clientID)
            self.player!.login(withAccessToken: authSession.accessToken)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        SPTAuth.defaultInstance().clientID = "c32c4b25afb545a9824c43ac88a32247"
        SPTAuth.defaultInstance().redirectURL = URL(string: "gitswole://returnAfterLogin")
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
    }
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
        print("logged in")
        self.player?.playSpotifyURI("spotify:track:58s6EuEYJdlb0kO7awm3Vp", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if UIApplication.shared.openURL(loginUrl!) {
            if auth.canHandle(auth.redirectURL) {
                // To do - build in error handling
            }
        }
    }

    @IBAction func logout(_ sender: Any) {
        AuthService.user.signOut()
        enableDisableButtons()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularWorkoutImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularWorkoutCell", for: indexPath) as! PopularWorkoutCollectionViewCell
        
        cell.workoutImage.image = popularWorkoutImages[indexPath.row]
        
        return cell
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

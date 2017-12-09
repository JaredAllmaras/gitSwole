//
//  DummyViewController.swift
//  gitSwole
//
//  Created by Jared Allmaras on 12/8/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class DummyViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
         if !LoginManager.shared.isLogged {
            let spotifyLoginVC = storyboard?.instantiateViewController(withIdentifier: "SpotifyLoginVC") as? SpotifyLoginViewController
            viewControllers = [spotifyLoginVC!]
         } else {
            LoginManager.shared.preparePlayer()
            
         }
        
        
        
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

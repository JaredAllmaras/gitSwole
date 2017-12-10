//
//  DummyViewController.swift
//  gitSwole
//
//  Created by Jared Allmaras on 12/8/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit


class DummyViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
         setView()
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setView() {
        if !LoginManager.shared.isLogged {
            if let spotifyLoginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpotifyLoginVC") as? SpotifyLoginViewController {
                self.navigationController?.pushViewController(spotifyLoginVC, animated: false)
            }
        } else {
            LoginManager.shared.preparePlayer()
            if let playlistVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlaylistVC") as? PlaylistViewController {
                self.navigationController?.pushViewController(playlistVC, animated: false)
            }
        }
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

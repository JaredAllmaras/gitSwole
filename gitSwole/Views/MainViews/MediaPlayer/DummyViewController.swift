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
        
        if !LoginManager.shared.isLogged {
            self.performSegue(withIdentifier: "isNotLoggedIn", sender: self)
        } else {
            self.performSegue(withIdentifier: "isLoggedIn", sender: self)
        }
        
        }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


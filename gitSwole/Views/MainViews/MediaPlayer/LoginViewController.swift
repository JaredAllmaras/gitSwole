//
//  LoginViewController.swift
//  gitSwole
//
//  Created by Jared Allmaras on 11/30/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
     private func configureView() {
         LoginManager.shared.delegate = self
         configureLoginButton()
         view.backgroundColor = .spotifyBackground
     }
    
     private func configureLoginButton() {
         let buttonWidth = view.frame.width - 100.0
         let buttonFrame = CGRect(x: (view.bounds.width - buttonWidth)/2, y: view.bounds.height/2, width: buttonWidth, height: 50)
         let button = UIButton(frame: buttonFrame)
         button.backgroundColor = UIColor.spotifyGreen
         button.layer.cornerRadius = 25
         button.layer.masksToBounds = true
         button.addTarget(self, action: #selector(loginAction(sender:)), for: .touchUpInside)
         button.setTitle("LOGIN", for: .normal)
         button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
         button.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(button)
        
         let titleLabel = UILabel()
         titleLabel.textColor = .white
         titleLabel.text = "Please login here"
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(titleLabel)
        
         button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
         button.widthAnchor.constraint(equalToConstant: 200).isActive = true
         button.heightAnchor.constraint(equalToConstant: 50).isActive = true
         titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         titleLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10).isActive = true
     }
    
     // MARK: Login handling
    
}

     extension LoginViewController: LoginManagerDelegate {
     func loginManagerDidLoginWithSuccess() {
     UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
     dismiss(animated: true, completion: nil)
     }
 }

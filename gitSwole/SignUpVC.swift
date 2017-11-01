//
//  SignUpVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {
    
    let primaryBackground = UIColor(red: 1.00, green: 0.40, blue: 0.35, alpha: 1.0)

    @IBOutlet weak var secondPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = primaryBackground
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signUp(_ sender: Any) {
        if validUsername(username: usernameTextField.text!) && validEmail(email: emailTextField.text!) && validPassword(password: passwordTextField.text!) {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if error == nil {
                    print("Firebase sign up was successful!")
                    _ = self.navigationController?.popViewController(animated: true)
                } else {
                    print("Error signing up for Firebase")
                    print(error!.localizedDescription)
                }
            })
        } else {
            print("Invalid username, email, or password")
        }
    }
    
    private func validUsername(username: String) -> Bool {
        return true
    }
    
    private func validEmail(email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
        let validationStatus = NSPredicate(format:"SELF MATCHES %@", regEx)
        return validationStatus.evaluate(with: email)
    }
    
    private func validPassword(password: String) -> Bool {
        return true
    }
    
    @IBAction func cancel(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
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

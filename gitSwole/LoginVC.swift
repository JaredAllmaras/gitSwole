//
//  LoginVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit
import Firebase


class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(_ sender: Any) {
        if validEmail(email: email.text!) && validPW(password: password.text!) {
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
                // return to home screen
                print("User signed in successfully")
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func validEmail(email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
        let validationStatus = NSPredicate(format:"SELF MATCHES %@", regEx)
        return (validationStatus.evaluate(with: email) == false)
    }
    
    private func validPW(password: String) -> Bool {
        return password != ""
    }
    
    @IBAction func cancel(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func register(_ sender: Any) {
        let storyboard = UIStoryboard(name: "NathanStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signUpVC")
        self.present(vc, animated: true, completion: nil)
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

//
//  LoginVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginVC: UIViewController {
    
    let primaryBackground = UIColor(red: 1.00, green: 0.40, blue: 0.35, alpha: 1.0)

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = primaryBackground
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(_ sender: Any) {
        
//        if user not signed in {
//
//        }
        if !DataSource.dataSource.signedIn() {
            if validEmail(email: email.text!) && validPW(password: password.text!) {
                Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
                    if error == nil {
                        print("User signed in successfully")
                        DataSource.dataSource.configure(user: user!)
                        _ = self.navigationController?.popViewController(animated: true)
                    } else {
                        print("Error signing in to Firebase")
                        print(error!.localizedDescription)
                    }
                }
            } else {
                print("Invalid Username or Password")
            }
        }
    }
    
    private func validEmail(email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
        let validationStatus = NSPredicate(format:"SELF MATCHES %@", regEx)
        return validationStatus.evaluate(with: email)
    }
    
    private func validPW(password: String) -> Bool {
        return password != ""
    }
    
    @IBAction func cancel(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func register(_ sender: Any) {
    }
    
    // This method is called when the user touches the Return key on the
    // keyboard. The 'textField' passed in is a pointer to the textField
    // the cursor was in at the time they touched the Return key on the
    // keyboard.
    //
    // From the Apple documentation: Asks the delegate if the text field
    // should process the pressing of the return button.
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Code for keyboard dismissal when user touches outside textFields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

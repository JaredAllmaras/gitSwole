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
    
    @IBOutlet weak var secondPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Config.primaryColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Validate and add user to firebase user auth object
    @IBAction func signUp(_ sender: Any) {
        
        let username = usernameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if validUsername(username) && validEmail(email) && validPassword(password) {
            UserService.user.signUp(username, email, password)
            _ = navigationController?.popViewController(animated: true)
//            let storyboard = UIStoryboard(name: "NickStoryboard", bundle: nil)
//            let loadingVC = storyboard.instantiateViewController(withIdentifier: "LoadingScreen") as! LoadingViewController
//            _ = navigationController?.pushViewController(loadingVC, animated: true)
        } else {
            print("Invalid username, email, or password")
        }
    }
    
    private func validUsername(_ username: String) -> Bool {
        return username != ""
    }
    
    private func validEmail(_ email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
        let validationStatus = NSPredicate(format:"SELF MATCHES %@", regEx)
        return validationStatus.evaluate(with: email)
    }
    
    private func validPassword(_ password: String) -> Bool {
        return password != "" && password == secondPasswordTextField.text!
    }
    
    @IBAction func cancel(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // This method is called when the user touches the Return key on the
    // keyboard. The 'textField' passed in is a pointer to the textField
    // the cursor was in at the time they touched the Return key on the
    // keyboard.
    //
    // From the Apple documentation: Asks the delegate if the text field
    // should process the pressing of the return button.
    //
    //Code for keyboard dismissal when user touches outside textField
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

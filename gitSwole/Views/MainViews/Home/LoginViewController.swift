//
//  LoginVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController, SignUpProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Config.backgroundColor
        
        titleView.backgroundColor = Config.primaryLightColor
        titleView.layer.cornerRadius = 15
        
        titleLabel.textColor = Config.primaryTextColor
        
        emailTextField.placeholder = "email"
        passwordTextField.placeholder = "password"
       
        signInButton.backgroundColor = Config.buttonBackgroundColor
        signInButton.setTitleColor(Config.buttonTextColor, for: .normal)
        signInButton.layer.cornerRadius = Config.buttonCornerRadius
        signUpButton.backgroundColor = Config.buttonBackgroundColor
        signUpButton.setTitleColor(Config.buttonTextColor, for: .normal)
        signUpButton.layer.cornerRadius = Config.buttonCornerRadius
        cancelButton.backgroundColor = Config.buttonBackgroundColor
        cancelButton.setTitleColor(Config.buttonTextColor, for: .normal)
        cancelButton.layer.cornerRadius = Config.buttonCornerRadius
        
        errorLabel.backgroundColor = Config.primaryDarkColor
        errorLabel.textColor = Config.primaryTextColor
        errorLabel.layer.cornerRadius = 5
        errorLabel.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signIn(_ sender: Any) {
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        
        if validEmail(email) && validPW(password) {
//            AuthManager.user.signIn(email, password, self)
        } else {
            errorLabel.text = "Invalid Username or Password"
            errorLabel.isHidden = false
        }
    }
    
    func proceed() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func error(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    private func validEmail(_ email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
        let validationStatus = NSPredicate(format:"SELF MATCHES %@", regEx)
        return validationStatus.evaluate(with: email)
    }
    
    private func validPW(_ password: String) -> Bool {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

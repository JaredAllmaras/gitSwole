//
//  SignUpVC.swift
//  gitSwole
//
//  Created by Nathan Mosley on 10/31/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol SignUpProtocol {
    func proceed() -> Void
    func error(_ message:String) -> Void
}

class SignUpViewController: UIViewController, SignUpProtocol {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Config.backgroundColor
        
        emailTextField.placeholder = "email"
        passwordTextField.placeholder = "password"
        
        errorLabel.backgroundColor = Config.primaryDarkColor
        errorLabel.textColor = Config.primaryTextColor
        errorLabel.layer.cornerRadius = 5
        errorLabel.isHidden = true
        
        signUpButton.backgroundColor = Config.buttonBackgroundColor
        signUpButton.setTitleColor(Config.buttonTextColor, for: .normal)
        signUpButton.layer.cornerRadius = Config.buttonCornerRadius
        
        cancelButton.backgroundColor = Config.buttonBackgroundColor
        cancelButton.setTitleColor(Config.buttonTextColor, for: .normal)
        cancelButton.layer.cornerRadius = Config.buttonCornerRadius
        
        titleLabel.textColor = Config.primaryTextColor
        titleView.backgroundColor = Config.primaryLightColor
        titleView.layer.cornerRadius = 15
        
    }
    
    // Validate and add user to firebase user auth object
    @IBAction func signUp(_ sender: Any) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!

        if validEmail(email) && validPassword(password) {
            AuthService.user.signUp(email, password, self)
        } else {
            error("Invalid email or password")
            errorLabel.isHidden = false
        }
    }
    
    private func validEmail(_ email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
        let validationStatus = NSPredicate(format:"SELF MATCHES %@", regEx)
        return validationStatus.evaluate(with: email)
    }
    
    private func validPassword(_ password: String) -> Bool {
        return password != ""
    }
    
    @IBAction func cancel(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func proceed() {
        let storyboard = UIStoryboard(name: "NathanStoryboard", bundle: nil)
        let userStateFormViewController = storyboard.instantiateViewController(withIdentifier: "UserStateFormViewController") as! UserStateFormViewController
        present(userStateFormViewController, animated: true, completion: nil)
//        _ = navigationController?.popViewController(animated: true)
    }
    
    func error(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
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

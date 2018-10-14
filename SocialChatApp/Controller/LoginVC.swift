//
//  LoginVC.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/7/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func signInButtonPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil{
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!) { (success, error) in
                if success{
                    self.dismiss(animated: true, completion: nil)
                } else{
                    print(String(describing: error?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (success, registrationError) in
                    if success{
                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userLoginComplete: { (success, logInError) in
                            print("Registered User")
                        })
                    }else{
                        print(String(describing: registrationError?.localizedDescription))
                    }
                })
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LoginVC : UITextFieldDelegate{
    
}

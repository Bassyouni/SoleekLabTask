//
//  LoginVC.swift
//  SoleeklabTask
//
//  Created by MacBook Pro on 10/15/18.
//  Copyright © 2018 Bassyouni. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import IHKeyboardAvoiding

class LoginVC: ParentViewController  {

    //MARK:- iboutlets
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var loginView: LoginView!

    
    //MARK:- view methods
    override func viewDidLoad() {
        super.viewDidLoad()
    // master changes,, branch changes
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.tag = 1
        passwordTextField.tag = 2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
        
        KeyboardAvoiding.avoidingView = loginView
    }
    
    
    
    //MARK:- ibactions
    @IBAction func loginPressed(_ sender: Any)
    {
        
        if isInputsValidated()
        {
            if let email = emailTextField.text , let password = passwordTextField.text
            {
                 showLoading()
                
                UserAuthentication.signIn(email: email, password: password) { (errorMessage) in
                    
                    if let errorMessage = errorMessage
                    {
                        self.showErrorAlert(message: errorMessage)
                    }
                    else
                    {
                        self.goToHomeVC()
                    }
                    self.hideLoading()
                }
            }
        }

        
    }
    
    
    //MARK:- functions
    @objc private func handleTap()
    {
        self.view.endEditing(true)
    }
    
    private func isInputsValidated() -> Bool
    {
        // remove error messages, if any exist
        emailTextField.errorMessage = ""
        passwordTextField.errorMessage = ""
        
        if emailTextField.text == ""
        {
            emailTextField.errorMessage = "Please Enter Email"
            return false
        }
        if passwordTextField.text == ""
        {
            passwordTextField.errorMessage = "Please Enter Password"
            return false
        }
        return true
    }
    
    private func goToHomeVC()
    {
        view.endEditing(true)
        if let countriesVC = storyboard?.instantiateViewController(withIdentifier: "CountriesVC")
        {
            self.present(countriesVC, animated: true)
        }
        
    }
    
}


//MARK:- keyboard delegates
extension LoginVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}


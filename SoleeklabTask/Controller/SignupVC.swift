//
//  SignupVC.swift
//  SoleeklabTask
//
//  Created by MacBook Pro on 10/15/18.
//  Copyright © 2018 Bassyouni. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class SignupVC: ParentViewController {
    
    //MARK:- iboutles
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confrimPasswordView: UIView!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var containorView: UIView!
    
    //MARK:- viewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
        
        KeyboardAvoiding.avoidingView = containorView
    }
    
    
    
    //MARK:- ibactions
    @IBAction func SignUpBtnPressed(_ sender: Any)
    {
        showLoading()
        
        if isInputsValidated()
        {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            UserAuthentication.signUp(email: email, password: password) { (errorMessage) in
                
                if let errorMessage = errorMessage
                {
                    self.showErrorAlert(message: errorMessage)
                }
                else
                {
                    self.goToHomeVC()
                }
            }
            
        }
        
        hideLoading()

    }
    
    @IBAction func backBtnPressed(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- functions
    @objc private func handleTap()
    {
        self.view.endEditing(true)
    }
    
    private func goToHomeVC()
    {
        view.endEditing(true)
        if let countriesVC = storyboard?.instantiateViewController(withIdentifier: "CountriesVC")
        {
            self.present(countriesVC, animated: true)
        }
    }
    
    
    //MARK:- input validations
    private func isInputsValidated() -> Bool
    {
        if emailTextField.text == ""
        {
            showErrorAlert(message: "please fill in your email")
            return false
        }
        if passwordTextField.text == ""
        {
            showErrorAlert(message: "please fill in your password")
            return false
        }
        if confirmPasswordTextField.text == ""
        {
            showErrorAlert(message: "please fill in confrim password")
            return false
        }
        if !isValidEmail(testStr: emailTextField.text!)
        {
            showErrorAlert(message: "email is not valid")
            return false
        }
        if !isvalidPassword(value: passwordTextField.text!)
        {
            showErrorAlert(message: "please make sure the password is more than 7 characters")
            return false
        }
        if !isPasswordSame(password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!)
        {
            showErrorAlert(message: "Passwords don't match")
            return false
        }
        
        return true
        
        
    }
    
    private func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    private func isvalidPassword(value: String) -> Bool
    {
        if value.count >= 8
        {
            return true
        }
        return false
    }
    
    private func isPasswordSame(password: String , confirmPassword : String) -> Bool
    {
        if password == confirmPassword {
            return true
        }else{
            return false
        }
    }
    
}


extension SignupVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}




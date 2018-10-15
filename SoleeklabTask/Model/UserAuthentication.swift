//
//  UserAuthentication.swift
//  SoleeklabTask
//
//  Created by MacBook Pro on 10/15/18.
//  Copyright © 2018 Bassyouni. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserAuthentication
{
    //MARK:- Varibales
    private let userDefualtsKey = "CurrentUserUid"
    
    //MARK:- Static Functions
    class func signUp(email: String, password: String, complition: @escaping (_ errorMessage: String?) -> ())
    {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error
            {
                print(error.localizedDescription)
                complition(error.localizedDescription)
                return
            }
            
            guard let user = authResult?.user else {
                print("something went wrong in createUser")
                complition("something went wrong, please try again later")
                return
            }
        
            UserAuthentication().saveUserSession(userUid: user.uid)
            complition(nil)
        }
    }
    
    class func signIn(email: String, password: String, complition: @escaping (_ errorMessage: String?) -> ())
    {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error
            {
                print(error.localizedDescription)
                complition(error.localizedDescription)
                return
            }
            
            guard let user = authResult?.user else {
                print("something went wrong with sign in")
                complition("something went wrong, please try again later")
                return
            }

            UserAuthentication().saveUserSession(userUid: user.uid)
            complition(nil)
        }
    }

    class func isSessionLive() -> Bool
    {
        let userDefaultskey = UserAuthentication().userDefualtsKey
        
        if UserDefaults.standard.object(forKey: userDefaultskey) == nil {
            return false
        }
        
        return true
    }
    
    class func logOut()
    {
        UserAuthentication().removeUserSession()
    }
    
    
    //MARK:- private functions
    private func saveUserSession(userUid: String)
    {
        UserDefaults.standard.set(userUid, forKey: userDefualtsKey)
    }
    
    private func removeUserSession()
    {
        UserDefaults.standard.removeObject(forKey: userDefualtsKey)
    }
    
    
}

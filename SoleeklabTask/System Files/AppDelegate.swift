//
//  AppDelegate.swift
//  SoleeklabTask
//
//  Created by MacBook Pro on 10/15/18.
//  Copyright © 2018 Bassyouni. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        if UserAuthentication.isSessionLive()
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let countryVC = storyboard.instantiateViewController(withIdentifier: "CountriesVC")
            window = UIWindow()
            window?.makeKeyAndVisible()
            window?.rootViewController = countryVC
        }

        return true
    }

}


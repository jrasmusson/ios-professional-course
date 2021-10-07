//
//  AppDelegate.swift
//  Bankey
//
//  Created by jrasmusson on 2021-09-23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let loginViewController = LoginViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        
        window?.rootViewController = loginViewController
//        window?.rootViewController = AccountSummaryViewController()
//        window?.rootViewController = OnboardingContainerViewController()

        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        // Display home screen
        print("foo - Did login")
    }
}

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
    let onboardingViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
                
        loginViewController.delegate = self
        onboardingViewController.delegate = self
        
        let vc = AccountSummaryViewController()
        let statusBarBackgroundView = UIView.makeStatusBarBackgroundView()
        vc.view.addSubview(statusBarBackgroundView)
        
        window?.rootViewController = vc
        
        return true
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingViewController)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension UIView {
//    func setStatusBar() {
//        if #available(iOS 13.0, *) {
//            let app = UIApplication.shared
//            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
//
//            let statusbarView = UIView()
//            statusbarView.backgroundColor = UIColor.red
//            view.addSubview(statusbarView)
//
//            statusbarView.translatesAutoresizingMaskIntoConstraints = false
//            statusbarView.heightAnchor.constraint(equalToConstant: statusBarHeight).isActive = true
//            statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
//            statusbarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//            statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        } else {
//            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
//            statusBar?.backgroundColor = UIColor.red
//        }
//    }
    
    static func makeStatusBarBackgroundView() -> UIView {
            let statusBarSize = UIApplication.shared.statusBarFrame.size // deprecated
            let frame = CGRect(origin: .zero, size: statusBarSize)
            let statusBackgroundView = UIView(frame: frame)
            statusBackgroundView.backgroundColor = .systemTeal
            statusBackgroundView.layer.zPosition = 100
            return statusBackgroundView
        }
}

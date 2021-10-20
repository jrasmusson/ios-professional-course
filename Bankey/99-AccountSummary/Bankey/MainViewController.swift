//
//  MainViewController.swift
//  Bankey
//
//  Created by jrasmusson on 2021-10-11.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        let summaryVC = AccountSummaryViewController()
        let moneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()
        
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")

        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)

        tabBar.tintColor = .systemTeal
        tabBar.isTranslucent = false

        let tabBarList = [summaryNC, moneyNC, moreNC]

        viewControllers = tabBarList
    }
}

class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGray5
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGray4
    }
}

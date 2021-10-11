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
        view.backgroundColor = .systemPurple

        let summaryVC = SummaryViewController()
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")

        let moveMoneyVC = MoveMoneyViewController()
        moveMoneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")

        let moreVC = MoreViewController()
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")

        let tabBarList = [summaryVC, moveMoneyVC, moreVC]

        viewControllers = tabBarList
    }
}

class SummaryViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGray6
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

extension UIViewController {
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}

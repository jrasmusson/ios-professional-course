//
//  MoreViewController.swift
//  Bankey
//
//  Created by jrasmusson on 2021-11-11.
//

import Foundation

import UIKit

class MoreViewController: UIViewController {
    
    let stackView = UIStackView()
    let resetOnboardingButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension MoreViewController {
    func style() {
        title = "More"
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        resetOnboardingButton.translatesAutoresizingMaskIntoConstraints = false
        resetOnboardingButton.configuration = .filled()
        resetOnboardingButton.setTitle("Reset Onboarding", for: [])
        resetOnboardingButton.addTarget(self, action: #selector(resetOnboardingTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(resetOnboardingButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: Actions
extension MoreViewController {

    @objc func resetOnboardingTapped(sender: UIButton) {
        LocalState.hasOnboarded = false
    }
}

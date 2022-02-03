//
//  PasswordStatusView.swift
//  Password
//
//  Created by jrasmusson on 2022-02-02.
//

import Foundation
import UIKit

class PasswordStatusView: UIView {
    let stackView = UIStackView()
    
    let criteriaLabel = UILabel()
    
    let lengthCriteriaView = PasswordCriteriaView(text: "8-32 characters (no spaces)")
    let uppercaseCriteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
    let lowerCaseCriteriaView = PasswordCriteriaView(text: "lowercase (a-z)")
    let digitCriteriaView = PasswordCriteriaView(text: "digit (0-9)")
    let specialCharacterCriteriaView = PasswordCriteriaView(text: "special character (e.g. !@#$%^)")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension PasswordStatusView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemFill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        
        criteriaLabel.numberOfLines = 0
        criteriaLabel.lineBreakMode = .byWordWrapping
        criteriaLabel.attributedText = makeCriteriaMessage()
        
        lengthCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        uppercaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        lowerCaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        digitCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterCriteriaView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(uppercaseCriteriaView)
        stackView.addArrangedSubview(lowerCaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterCriteriaView)
        
        addSubview(stackView)

        // Stack layout
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2)
        ])
    }
    
    private func makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)

        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))

        return attrText
    }
}


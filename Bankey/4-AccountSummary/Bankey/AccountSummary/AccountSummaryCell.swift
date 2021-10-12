//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by jrasmusson on 2021-10-12.
//

import UIKit

class AccountSummaryCell: UITableViewCell {

    let courseName = UILabel()
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 150
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set any attributes of your UI components here.
        courseName.translatesAutoresizingMaskIntoConstraints = false
        courseName.font = UIFont.systemFont(ofSize: 20)
        courseName.text = "Foo"
        
        // Add the UI components
        contentView.addSubview(courseName)
        
        NSLayoutConstraint.activate([
            courseName.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            courseName.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

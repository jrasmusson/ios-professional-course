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
            courseName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            courseName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            courseName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            courseName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

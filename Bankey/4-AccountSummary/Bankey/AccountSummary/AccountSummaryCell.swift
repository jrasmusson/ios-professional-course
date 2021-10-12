//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by jrasmusson on 2021-10-12.
//


import Foundation
import UIKit

class AccountSummaryCell: UITableViewCell {
    
    let typeLabel = UILabel()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 80

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryCell {
    private func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    private func layout() {
        contentView.addSubview(typeLabel)
        
        NSLayoutConstraint.activate([
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            typeLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

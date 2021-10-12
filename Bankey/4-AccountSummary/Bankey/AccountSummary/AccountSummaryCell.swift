//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by jrasmusson on 2021-10-12.
//

import UIKit

class AccountSummaryCell: UITableViewCell {

    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
        
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
        
    let chevonImageView = UIImageView()

    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 150
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryCell {
    
    private func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.systemFont(ofSize: 20)
        typeLabel.text = "Foo"
    }
    
    private func layout() {
        contentView.addSubview(typeLabel) // imporant!
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
        ])
    }
}

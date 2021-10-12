//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by jrasmusson on 2021-10-11.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0),
            contentView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: contentView.trailingAnchor, multiplier: 0),
            bottomAnchor.constraint(equalToSystemSpacingBelow: contentView.bottomAnchor, multiplier: 0)
        ])
    }
}

//
//  AccountSummaryCell+ViewModel.swift
//  Bankey
//
//  Created by jrasmusson on 2021-11-06.
//

import Foundation
import UIKit

extension AccountSummaryCell {
    
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
    }
 
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal

        var balanceAsAttributedString: NSAttributedString {
            let tuple = balanceAsDollarsAndCents
            return makeBalanceAttributed(dollars: tuple.0, cents: tuple.1)
        }
        
        var balanceAsDollarsAndCents: (String, String) { // 929466.23
            let parts = modf(balance.doubleValue) // 929466 0.23
            
            let dollars = parts.0.convertToDollar
            let cents = parts.1.convertToCents
            
            return (dollars, cents) // "929,466" "23"
        }
        
        private func makeBalanceAttributed(dollars: String, cents: String) -> NSMutableAttributedString {
            let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
            let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
            let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
            
            let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
            let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
            let centString = NSAttributedString(string: cents, attributes: centAttributes)
            
            rootString.append(dollarString)
            rootString.append(centString)
            
            return rootString
        }
    }}

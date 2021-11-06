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
            
            let dollars = convertToDollarString(parts.0) // "929,466"
            let cents = convertToCents(parts.1) // "23"
            
            return (dollars, cents) // "929,466" "23"
        }
        
        func convertToDollarString(_ dollarPart: Double) -> String { // 929466
            let dollarsWithDecimal = dollarsFormatted(dollarPart) // "$929,466.00"
            let formatter = NumberFormatter()
            let decimalSeparator = formatter.decimalSeparator! // "."
            let dollarComponents = dollarsWithDecimal.components(separatedBy: decimalSeparator) // "$929,466" "00"
            var dollars = dollarComponents.first! // "$929,466"
            dollars.removeFirst() // "929,466"

            return dollars
        }
        
        func convertToCents(_ centPart: Double) -> String { // 0.23
            let cents: String
            if centPart == 0 {
                cents = "00"
            } else {
                cents = String(format: "%.0f", centPart * 100) // "23"
            }
            return cents
        }
        
        private func dollarsFormatted(_ dollars: Double) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.usesGroupingSeparator = true
            
            if let result = formatter.string(from: dollars as NSNumber) {
                return result
            }
            
            return ""
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

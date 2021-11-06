//
//  Double+Utils.swift
//  Bankey
//
//  Created by jrasmusson on 2021-11-06.
//

import Foundation

extension Double {
    
    // Convert 929466 > "$929,466.00
    var asFormattedCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: self as NSNumber) {
            return result
        }
        
        return ""
    }
    
    // Convert 929466 > "929,466
    var convertToDollar: String {
        let dollarsWithDecimal = self.asFormattedCurrency
        let formatter = NumberFormatter()
        let decimalSeparator = formatter.decimalSeparator! // "."
        let dollarComponents = dollarsWithDecimal.components(separatedBy: decimalSeparator)
        var dollars = dollarComponents.first! // Drop $
        dollars.removeFirst()

        return dollars
    }
    
    // Convert 0.23 > "23"
    var convertToCents: String {
        let cents: String
        if self == 0 {
            cents = "00"
        } else {
            cents = String(format: "%.0f", self * 100)
        }
        return cents
    }
}

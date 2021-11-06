//
//  Double+Utils.swift
//  Bankey
//
//  Created by jrasmusson on 2021-11-06.
//

import Foundation

extension Double {    
    var dollarsFormatted: String { // 929466
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: self as NSNumber) {
            return result // "$929,466.00"
        }
        
        return ""
    }
}

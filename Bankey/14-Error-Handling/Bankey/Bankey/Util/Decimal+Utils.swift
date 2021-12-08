//
//  Decimal+Utils.swift
//  Bankey
//
//  Created by jrasmusson on 2021-11-08.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}

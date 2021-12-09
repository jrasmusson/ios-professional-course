//
//  ProfileNetworkingTests.swift
//  BankeyUnitTests
//
//  Created by jrasmusson on 2021-12-09.
//

import Foundation

import XCTest

@testable import Bankey

class ProfileNetworkingTests: XCTestCase {
    var vc: AccountSummaryViewController!
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        vc.loadViewIfNeeded()
    }
    
    func testFetchProfile() throws {
        XCTAssertNil(vc.profile)
        vc.fetchProfile(group: DispatchGroup(), userId: "1")
        XCTAssertNotNil(vc.profile)
    }
}

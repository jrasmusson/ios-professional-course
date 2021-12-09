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
    var profileManager: ProfileManageable!
    
    struct StubProfileManager: ProfileManageable {
        var profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            completion(.success(profile))
        }
    }
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        
        profileManager = StubProfileManager()
        vc.profileManageable = profileManager!
        
        vc.loadViewIfNeeded()
    }
    
    func testFetchProfile() throws {
        vc.profile = nil
        XCTAssertNil(vc.profile)
        vc.fetchProfile(group: DispatchGroup(), userId: "1")
        XCTAssertNotNil(vc.profile)
    }
}


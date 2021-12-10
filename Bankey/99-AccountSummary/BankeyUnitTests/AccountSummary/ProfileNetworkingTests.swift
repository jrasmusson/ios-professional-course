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
    var stubManager: StubProfileManager!
    
    class StubProfileManager: ProfileManageable {
        var profile: Profile?
        var error: NetworkError?
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
    }
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        
        stubManager = StubProfileManager()
        vc.profileManageable = stubManager
    }
        
//    func testAlertForServerError() throws {
//        stubManager.error = NetworkError.serverError
//
////        vc.forceFetchProfile()
//        vc.loadViewIfNeeded()
//        let alertVC = vc.presentedViewController as? UIAlertController
//
//        XCTAssertNotNil(alertVC)
//    }

    /*
     Unit testing is about looking for effects.
     You do something - you expect something to change.
     For us, we want to test that:
      - when fetchProfile succeeds - profile gets set
      - when fetchProfile fails - an alert pops up
     */
    
    /*
    Case 1: fetchProfile succeeds - happy path
     
     We can verify that the profile gets set on our view controller by
     stubbing out the manager, and then checking that the vc.profile got set.
     */
    
    func testFetch() throws {
        vc.forceFetchProfile()
        XCTAssertNotNil(stubManager.profile)
    }

    /*
     Case 2: fetchProfile fails
        2a - serverError
        2b - decodingError
     
     Only way we know if one error occurs over the other is to check the
     title and message of our UIAlertView. Getting access to viewControllers
     in unit tests is tricky. You have a lot of view hierarchy warnings and issues and because
     view heirarchies in tests don't always match runtime in production, setting up and testing
     for the presence of view controllers can be tricky.
     
     For example if we tried asserting for the presence of the alert and its associated title
     and message.
    
     We'd see warnings like this:
     
     Attempt to present <UIAlertController: 0x7feac005ea00> on <Bankey.AccountSummaryViewController: 0x7feac0031200> (from <Bankey.AccountSummaryViewController: 0x7feac0031200>) whose view is not in the window hierarchy.
     
     There are a couple of ways to deal with this.
     
     1. One is to break your logic down into smaller bits and do your unit tests on smaller pieces.
     2. Is to create instance variables of the things that are affected as a result of your test,
     and access those.
     
     Let's do both.
     
     
     */

    func testBadTest() throws {
        stubManager.error = NetworkError.serverError
        
        vc.forceFetchProfile()
        let alertVC = vc.presentedViewController as? UIAlertController
        
//        XCTAssertEqual("Server Error", alertVC?.title)
//        XCTAssertEqual("We could not process your request. Please try again.", alertVC?.message)
    }

    func testCheckForAlert() throws {
        let alert = UIAlertController(title: "a",
                                      message: "b",
                                      preferredStyle: .alert)
        XCTAssertEqual("a", alert.title)
    }
    
    func testAlertForServerError() throws {
        stubManager.error = NetworkError.serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", vc.errorAlert.message)
    }
}

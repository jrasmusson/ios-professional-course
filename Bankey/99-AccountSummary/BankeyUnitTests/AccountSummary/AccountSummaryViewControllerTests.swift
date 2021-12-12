//
//  ProfileNetworkingTests.swift
//  BankeyUnitTests
//
//  Created by jrasmusson on 2021-12-09.
//

import Foundation

import XCTest

@testable import Bankey

class AccountSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    class MockProfileManager: ProfileManageable {
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
        // vc.loadViewIfNeeded()
        
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessage(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. Please try again.", titleAndMessage.1)
    }
    
    func testTitleAndMessageForNetworkError() throws {
        let titleAndMessage = vc.titleAndMessage(for: .decodingError)
        XCTAssertEqual("Network Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.1)
    }
    
    func testTitleAndMessageForServerErrorLessCoupling() throws {
        let titleAndMessage = vc.titleAndMessage(for: .serverError)
        XCTAssertTrue(titleAndMessage.0.contains("Server"))
        XCTAssertTrue(titleAndMessage.1.contains("could not process"))
    }
    
    func testTitleAndMessageForNetworkErrorLessCoupling() throws {
        let titleAndMessage = vc.titleAndMessage(for: .decodingError)
        XCTAssertTrue(titleAndMessage.0.contains("Network"))
        XCTAssertTrue(titleAndMessage.1.contains("Ensure you are connected"))
    }
    
    func testAlertForServerError() throws {
        mockManager.error = NetworkError.serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", vc.errorAlert.message)
        
        // Less coupling
        XCTAssertTrue(vc.errorAlert.title!.contains("Server"))
        XCTAssertTrue(vc.errorAlert.message!.contains("process your request"))
    }
    
    func testAlertForDecodingError() throws {
        mockManager.error = NetworkError.decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Network Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
        
        // Less coupling
        XCTAssertTrue(vc.errorAlert.title!.contains("Network"))
        XCTAssertTrue(vc.errorAlert.message!.contains("Ensure you are connected"))
    }
}

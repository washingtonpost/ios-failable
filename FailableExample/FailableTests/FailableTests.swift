//
//  FailableTests.swift
//  FailableTests
//
//  Created by Davis, William on 5/23/16.
//  Copyright © 2016 Washington Post. All rights reserved.
//

@testable import Failable
import Foundation
import XCTest

class Hero {

    var name: String?
    var cape: Bool?
    
    required init?(name: String, wearsCape: Bool){
        self.name = name
        self.cape = wearsCape
    }

}

public enum FailableTestError: ErrorType {
    case FailableExampleError(String)

    public var description: String {
        switch self {
        case .FailableExampleError(let message):
            return message
        }
    }
}

class FailableTests: XCTestCase {

    //let error = NSError(domain: "FailableTests", code: 404, userInfo: nil)
    let error = FailableTestError.FailableExampleError("no batman")

    var batman: Hero? {
        return Hero(name: "batman", wearsCape: true)
    }

    // MARK: - Is Success Tests

    func testThatSuccessfulPropertyReturnsTrueForSuccessCase() {
        if let bats = batman {
            let result = Failable<Hero>.Success(bats)
            XCTAssertTrue(result.successful, "result is success should be true for success case")
        }
    }

    // MARK: - Value Tests

    func testThatValuePropertyReturnsValueForSuccessCase() {
        if let bats = batman {
            let result = Failable<Hero>.Success(bats)
            XCTAssertNotNil(result.value)
        }
    }

    func testThatValuePropertyReturnsNilForFailureCase() {
        let result = Failable<Hero>.Failure(error)
        XCTAssertNil(result.value, "result value should be nil for failure case")
    }

    // MARK: - Error Tests

    func testThatErrorPropertyReturnsNilForSuccessCase() {
        if let bats = batman {
            let result = Failable<Hero>.Success(bats)
            XCTAssertTrue(result.error == nil, "result error should be nil for success case")
        }
    }

    func testThatErrorPropertyReturnsErrorForFailureCase() {
        let result = Failable<Hero>.Failure(error)
        XCTAssertTrue(result.error != nil, "result error should not be nil for failure case")
    }

    // MARK: - Description Tests

    func testThatDescriptionStringMatchesExpectedValueForSuccessCase() {
        if let bats = batman {
            let result = Failable<Hero>.Success(bats)
            XCTAssertEqual(
                result.description,
                "Success: \(bats)",
                "result description should match expected value for success case"
            )
        }
    }

    func testThatDescriptionStringMatchesExpectedValueForFailureCase() {
        let result = Failable<Hero>.Failure(error)
        XCTAssertEqual(
            result.description,
            "Failure: \(error)",
            "result description should match expected value for failure case"
        )
    }
}

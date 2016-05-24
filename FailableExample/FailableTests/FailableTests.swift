//
//  FailableTests.swift
//  FailableTests
//
//  Created by Davis, William on 5/23/16.
//  Copyright © 2016 Washington Post. All rights reserved.
//

@testable import Failable
@testable import ObjectMapper
import Foundation
import XCTest

class Hero: Mappable {

    var name: String?
    var cape: Bool?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        cape <- map["cape"]
    }
}

class FailableTests: XCTestCase {

    let error = NSError(domain: "FailableTests", code: 404, userInfo: nil)

    var batman: Hero? {
        let JSON = ["name": "Batman", "cape": true]
        return Mapper<Hero>().map(JSON)
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
            "Failure: \(error.localizedDescription)",
            "result description should match expected value for failure case"
        )
    }
}

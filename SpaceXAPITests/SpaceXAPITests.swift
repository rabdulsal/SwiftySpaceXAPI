//
//  SpaceXAPITests.swift
//  SpaceXAPITests
//
//  Created by Rashad Abdul-Salam on 10/17/22.
//

import XCTest
@testable import SpaceXAPI

final class SpaceXAPITests: XCTestCase {
    
    var networkService = SXNetworkingService()
    var expectation = XCTestExpectation(description: "Testing SXNetworkingService")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testNetworkingGetData() async {
        expectation = XCTestExpectation(description: "Test getData()")
        self.networkService.getData { rocketJSON, error in
            guard let json = rocketJSON else { XCTFail("JSON should be present"); return }
            print("JSON: \(json)")
            XCTAssertTrue(error==nil && rocketJSON != nil, "JSON should be present and there should be no Error.")
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

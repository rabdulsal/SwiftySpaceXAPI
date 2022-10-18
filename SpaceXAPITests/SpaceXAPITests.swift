//
//  SpaceXAPITests.swift
//  SpaceXAPITests
//
//  Created by Rashad Abdul-Salam on 10/17/22.
//

import XCTest
@testable import SpaceXAPI

final class SpaceXAPITests: XCTestCase {
    
    var launchRequestService = SXLaunchRequestService()
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
    
    func makeExpectationDescription(_ description: String) {
        expectation = XCTestExpectation(description: description)
    }
    
    func testNetworkingGetData() async {
        self.makeExpectationDescription("Test getData()")
        self.launchRequestService.getLaunchData { rocketJSON, error in
            guard let json = rocketJSON else { XCTFail("JSON should be present"); return }
            print("JSON: \(json)")
            XCTAssertTrue(error==nil && rocketJSON != nil, "JSON should be present and there should be no Error.")
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLaunchProviderGetLaunches() async {
        self.makeExpectationDescription("Test getLaunchData()")
        
        let launchService = SXLaunchProviderService()
        launchService.getLaunchData { launches, error in
            if let err = error {
                XCTFail(err)
                return
            }
            XCTAssertTrue(launches.count > 0, "Should return more than '0' launches.")
            self.expectation.fulfill()
        }
        wait(for: [self.expectation], timeout: 10.0)
    }
    
    func testImageProviderService() async {
        self.makeExpectationDescription("Test ImageProvider")
        let service = SXImageProviderService(resourceURL: URL(string: "https://images2.imgbox.com/4f/e3/I0lkuJ2e_o.png")!)
        service.getMissionPatchImg { image, error in
            if let err = error {
                XCTFail("ERROR: \(err)")
                return
            }
            XCTAssertTrue(image.isKind(of: UIImage.self), "Object returned should be of Type UIImage.")
            self.expectation.fulfill()
        }
        self.setWaitTime()
    }
    
    func setWaitTime() {
        wait(for: [self.expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

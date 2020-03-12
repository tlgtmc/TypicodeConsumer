//
//  Test.swift
//  tmcTests
//
//  Created by Tolga Atmaca on 13.03.2020.
//  Copyright © 2020 Tolga Atmaca. All rights reserved.
//

import XCTest

class Test: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testFetchUserData() {
        let e = expectation(description: "Expecting a JSON data not nil")
        
        var userList: [User] = []

        ApiCall.getUsers() { apiResponse in
            switch(apiResponse.status) {
            case .success:
                self.userList = apiResponse.responseList as! [User]
                XCTAssertTrue(userList.count>0)
                self.userId = userList[0].id ?? 1
                e.fulfill()
            case .failure:
                print(apiResponse.error)
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}

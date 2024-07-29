//
//  cvsCodeChallengeTests.swift
//  cvs-code-challengeTests
//
//  Created by Jacob Ahn on 7/28/24.
//

import XCTest
@testable import cvs_code_challenge

final class cvsCodeChallengeTests: XCTestCase {
    
    var mockService: MockService!
    var viewModel: CvsSearchViewModel!
    
    override func setUp() {
        super.setUp()
        mockService = MockService()
        viewModel = CvsSearchViewModel(service: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testSuccessSearch() {
        let expectation = XCTestExpectation(description: "fetch images success")
        let searchTxt = "dog"
        mockService.getImage(searchTxt: searchTxt) { images in
            XCTAssertNotNil(images)
            XCTAssertEqual(images?.count, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFailureSearch() {
        let expectation = XCTestExpectation(description: "fetch images failure")
        let searchTxt = "invalid"
        mockService.getImage(searchTxt: searchTxt) { [weak self] images in
            XCTAssertNil(self?.viewModel.image(index: 0))
            XCTAssertEqual(self?.viewModel.numberOfImages, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)    }
}


class MockService: ServiceProtocol {
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        completion(nil)
    }
    
    func getImage(searchTxt: String, completion: @escaping ([FlickerImageResponse]?) -> Void) {
        if searchTxt == "dog" {
            let mockData = FlickerImageResponse(title: "dog image", link: "https:flickr/dog", media: ["m": "https://flickr.dog"], description: "description mock")
            completion([mockData])
        } else {
            completion(nil)
        }
    }
}

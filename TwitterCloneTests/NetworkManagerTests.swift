//
//  NetworkManagerTests.swift
//  TwitterCloneTests
//
//  Created by Sevde Aydın on 12/18/24.
//

import XCTest
@testable import TwitterClone

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    
    override func setUp() {
        sut = NetworkManager(urlSession: XCTest.createMockURLSession())
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        MockURLSession.completionHandler = nil
        super.tearDown()  // test sonrası temizleniyor
    }
    
    func testSuccessDataFetch() async {
        let sampleJson = NetworkManagerTests.loadJsonFile()
        var fetchedUserResponse: [User]?
        var networkError: NetworkError?
        let mockEndpoint = MockEndpoint.fetch(isValid: true)
        let mockUrl = mockEndpoint.createURLRequest()?.url
        let expectation = XCTestExpectation(description: "Should be fetched data")
        
        MockURLSession.completionHandler = { request in
            let response = HTTPURLResponse(url: mockUrl!, statusCode: 200, httpVersion: nil, headerFields: nil)
            print(mockUrl as Any)
            return (response, sampleJson)
        }
        
        // When
        do {
            fetchedUserResponse = try await sut.fetch(with: mockEndpoint) as [User]
            expectation.fulfill()
        } catch {
            networkError = error as? NetworkError
        }
        
        // Then
        await fulfillment(of: [expectation], timeout: 5.0)
        XCTAssertNil(networkError)
        XCTAssertNotNil(fetchedUserResponse)
    }
    
    func testFailedDataFetchInvalidUrl() async {
        // Given
        var fetchedUserResponse: User?
        var networkError: NetworkError?
        let mockEndpoint = MockEndpoint.fetch(isValid: false)
        let expactation = XCTestExpectation(description: "Should be fetched data")
        
        MockURLSession.completionHandler = { _ in
            throw NetworkError.invalidURL
        }
        
        // When
        do {
            fetchedUserResponse = try await sut.fetch(with: mockEndpoint)
            XCTFail("Should be failed!")
        } catch {
            networkError = error as? NetworkError
            expactation.fulfill()
        }
        
        // Then
        await fulfillment(of: [expactation], timeout: 2.0)
        XCTAssertNil(fetchedUserResponse)
        XCTAssertNotNil(networkError)
    }
    
    func testFailedDataFetchDecodeError() async {
        //Given
        let sampleJson = NetworkManagerTests.loadJsonFile(isCorruptedJson: true)
        var fetchedCharacterResponse: User?
        var networkError: NetworkError?
        let mockEndpoint = MockEndpoint.fetch(isValid: true)
        let mockUrl = mockEndpoint.createURLRequest()?.url
        let expectation = XCTestExpectation(description: "Should Be Fetched Data")
        
        MockURLSession.completionHandler = { request in
            let response = HTTPURLResponse(url: mockUrl!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response, sampleJson)
        }
        
        //When
        do {
            fetchedCharacterResponse = try await sut.fetch(with: mockEndpoint)
        } catch {
            networkError = error as? NetworkError
            expectation.fulfill()
        }
        
        //Then
        await fulfillment(of: [expectation], timeout: 2.0)
        XCTAssertNil(fetchedCharacterResponse)
        XCTAssertNotNil(networkError)
    }
}

extension XCTest {
    static func createMockURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSession.self]
        let urlSession = URLSession(configuration: configuration)
        return urlSession
    }
}

enum MockEndpoint: Endpoint {
    case fetch(isValid: Bool)
    
    var path: String {
        switch self {
        case .fetch(let isValid):
            return isValid ? "/fetch" : "fetch//"
        }
    }
    
    var baseURL: String {
        switch self {
        case .fetch(let isValid):
            return isValid ? "mock.com" : "mock.com/api"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
}

extension NetworkManagerTests {
    static func loadJsonFile(isCorruptedJson: Bool = false) -> Data {
        let sampleJsonURL = Bundle(for: NetworkManagerTests.self).url(forResource: isCorruptedJson ? "corruptedSample" : "userJson", withExtension: "json")
        return try! Data(contentsOf: sampleJsonURL!)
    }
}

//
//  CacheManagerTests.swift
//  TwitterCloneTests
//
//  Created by Sevde Aydın on 12/18/24.
//

import XCTest
@testable import TwitterClone

final class CacheManagerTests: XCTestCase {
    // system under test
    var sut: CacheManager!
    
    override func setUp() {
        super.setUp()
        sut = CacheManager(countLimit: 2)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testImageRetrieveSuccess() {
        // Given
        let mockUrl = "TestURL"
        let mockData = Data("mockData".utf8)
        
        // When & Then
        do {
            /// veriyi önbelleğe ekler. data boşsa .invalidData hatası fırlatır
            try sut.setImageCache(url: mockUrl, data: mockData)
            /// önbellekten veriyi geri çağırır. url önbellekte bulunmazsa .itemNotFound hatası fırlatır
            let cachedData = try sut.retrieveImageFromCache(with: mockUrl)
            /// dönen verinin önbelleğe eklenen veriyle eşit olup olmadığını kontrol eder
            XCTAssertEqual(cachedData, mockData)
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }
}

//
//  RemoveFeedLoaderTests.swift
//  
//
//  Created by Fernando Monteiro on 22/11/22.
//

import XCTest

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "http://a-url.com")
    }
}

// A colaborator to perform the request (could be AF, URLSession...)
class HTTPClient {
    
    // Singleton instance (with private initializer, so other objects cannot be created).
    // Do we need a Singleton? Or can there be other instances of HTTPClient?
    static let shared = HTTPClient()
    
    private init() {}
    
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient.shared
        let _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        // Arrange (Given)
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        
        
        // Act (When)
        sut.load()
        
        // Assert (Then)
        XCTAssertNotNil(client.requestedURL)
    }
}

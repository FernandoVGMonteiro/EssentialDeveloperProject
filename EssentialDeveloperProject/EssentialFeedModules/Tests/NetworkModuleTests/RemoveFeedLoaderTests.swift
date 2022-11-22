//
//  RemoveFeedLoaderTests.swift
//  
//
//  Created by Fernando Monteiro on 22/11/22.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    
    // The client is a dependency to be injected via init
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        client.get(from: URL(string: "http://a-url.com")!)
    }
}

// A colaborator to perform the request (could be AF, URLSession...)
protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    
    // This variable is used to "spy" on the request and should not be production code
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
    
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        let _ = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        // Arrange (Given)
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(client: client)
        
        
        // Act (When)
        sut.load()
        
        // Assert (Then)
        XCTAssertNotNil(client.requestedURL)
    }
}

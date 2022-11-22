//
//  RemoveFeedLoaderTests.swift
//  
//
//  Created by Fernando Monteiro on 22/11/22.
//

import XCTest

class RemoteFeedLoader {
    let url: URL
    let client: HTTPClient
    
    // The client and the url are dependencies to be injected via init
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load() {
        client.get(from: url)
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
        let url = URL(string: "http://a-url.com")!
        let client = HTTPClientSpy()
        let _ = RemoteFeedLoader(url: url, client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        // Arrange (Given)
        let url = URL(string: "http://a-given-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        
        // Act (When)
        sut.load()
        
        // Assert (Then)
        XCTAssertEqual(client.requestedURL, url)
    }
}

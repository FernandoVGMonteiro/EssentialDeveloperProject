//
//  URLSessionHTTPClientTests.swift
//  
//
//  Created by Fernando Monteiro on 24/01/23.
//

import XCTest

class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.dataTask(with: url) { _, _, _ in }
    }
}

class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_createsDataTaskWithURL() {
        let url = URL(string: "http://any-url.com")!
        let session = URLSessionSpy()
        let sut = URLSessionHTTPClient(session: session)
        
        sut.get(from: url)
        
        XCTAssertEqual(session.receivedURLs, [url])
    }
    
    // We are subclassing URLSession. But don't have access to the internal
    // implementation. Plus this types contain many methods we won't use
    private class URLSessionSpy: URLSession {
        var receivedURLs = [URL]()
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            // Capturing URL when dataTask() is called
            receivedURLs.append(url)
            
            // We don't want a request to be executed, so we return a fake DataTask
            return FakeURLSessionDataTask()
        }
        
        private class FakeURLSessionDataTask: URLSessionDataTask {}
    }
}

//
//  EssentioalFeedAPIEndToEndTests.swift
//  
//
//  Created by Fernando Monteiro on 09/02/23.
//

import XCTest
import NetworkModule


class EssentioalFeedAPIEndToEndTests: XCTestCase {
    
    // This test takes up to ~2.7 seconds to run, which is quite long.
    // So we probably don't want it running on our CI.
    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
        let testServerURL = URL(string: "http://essentialdeveloper.com/feed-case-study/test-api/feed")!
        let client = URLSessionHTTPClient()
        let loader = RemoteFeedLoader(url: testServerURL, client: client)
        
        let exp = expectation(description: "Wait for request to load")
        
        var receivedResult: LoadFeedResult?
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        switch receivedResult {
        case let .success(items):
            XCTAssertEqual(items.count, 8, "Expected 8 items in the test account feed")
        
        case let .failure(error):
            XCTFail("Expected successful feed result, got \(error) instead")
            
        default:
            XCTFail("Expected successful feed result, got no result instead")
        }
    }
}

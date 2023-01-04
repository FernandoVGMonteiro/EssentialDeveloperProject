//
//  RemoteFeedLoader.swift
//  
//
//  Created by Fernando Monteiro on 23/11/22.
//

import Foundation

// Can be declared public so other modules can implement it
public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Error?, HTTPURLResponse?) -> Void)
}

// Can also be used and initialized in other modules
// We prevent subclassing with final
public final class RemoteFeedLoader {
    
    // Properties are not being used outside of the class
    private let url: URL
    private let client: HTTPClient
    
    // Defining error
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: url) { error, response in
            if response != nil {
                completion(.invalidData)
                // Sometimes, people forget to return after completion.
                // That's why it's useful to capture an array inside our
                // spy, so as to guarantee that the function was completed
                // onse single time.
                return
            }
            completion(.connectivity)
        }
    }
}

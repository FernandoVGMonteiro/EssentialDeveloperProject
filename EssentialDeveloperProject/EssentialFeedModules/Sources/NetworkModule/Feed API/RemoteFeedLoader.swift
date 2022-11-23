//
//  RemoteFeedLoader.swift
//  
//
//  Created by Fernando Monteiro on 23/11/22.
//

import Foundation

// Can be declared public so other modules can implement it
public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Error) -> Void)
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
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error) -> Void = { _ in }) {
        client.get(from: url) { error in
            completion(.connectivity)
        }
    }
}

//
//  RemoteFeedLoader.swift
//  
//
//  Created by Fernando Monteiro on 23/11/22.
//

import Foundation

public enum HTTPClientResult {
    case success(HTTPURLResponse)
    case failure(Error)
}

// Can be declared public so other modules can implement it
public protocol HTTPClient {
    // Having a tuple creates impossible scenarios
    // (ex: having both error / response == nil).
    // So we replace it with an enum that represents the only two possibilities.
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
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
        client.get(from: url) { result in
            switch result {
            case .success(_):
                completion(.invalidData)
            case .failure(_):
                completion(.connectivity)
            }
        }
    }
}

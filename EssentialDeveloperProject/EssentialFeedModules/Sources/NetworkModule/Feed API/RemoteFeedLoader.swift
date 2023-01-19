//
//  RemoteFeedLoader.swift
//  
//
//  Created by Fernando Monteiro on 23/11/22.
//

import Foundation

public final class RemoteFeedLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            // Guarantees the closer will not be executed
            // after the client is deallocated
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                let result = FeedItemsMapper.map(data, from: response)
                completion(result)
            case .failure(_):
                completion(.failure(.connectivity))
            }
        }
    }
}

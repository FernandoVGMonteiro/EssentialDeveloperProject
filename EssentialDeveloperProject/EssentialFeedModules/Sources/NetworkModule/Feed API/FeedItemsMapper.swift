//
//  FeedItemsMapper.swift
//  
//
//  Created by Fernando Monteiro on 19/01/23.
//

import Foundation

final class FeedItemsMapper {

    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let image: URL
        
        var item: FeedItem {
            return FeedItem(id: id,
                            description: description,
                            location: location,
                            imageURL: image)
        }
    }
    
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedItem] {
        guard response.statusCode == 200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        return try JSONDecoder()
            .decode(Root.self, from: data)
            .items.map { $0.item }
    }
    
    private struct Root: Decodable {
        let items: [Item]
    }
}

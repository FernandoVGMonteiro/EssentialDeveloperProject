//
//  FeedLoader.swift
//  EssentialDeveloperProject
//
//  Created by Fernando Monteiro on 22/11/22.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}

//
//  FeedLoader.swift
//  EssentialDeveloperProject
//
//  Created by Fernando Monteiro on 22/11/22.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}

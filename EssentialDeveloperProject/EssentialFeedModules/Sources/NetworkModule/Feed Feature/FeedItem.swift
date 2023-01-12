//
//  FeedItem.swift
//  EssentialDeveloperProject
//
//  Created by Fernando Monteiro on 22/11/22.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}

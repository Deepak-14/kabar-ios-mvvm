//
//  NewsModelS.swift
//  Kabar
//
//  Created by user on 24/08/26.
//

import SwiftData
import SwiftUI

@Model
final class NewsArticleSave {
//    @Attribute(.unique)
    var id: UUID
    
    var articleURL: String
    var title: String?
    var articleDescription: String?
    var imageURL: String?
    var author: String?
    var publishedAt: String?
    var content: String?

    init(
        id: UUID,
        articleURL: String,
        title: String?,
        articleDescription: String?,
        imageURL: String?,
        author: String?,
        publishedAt: String?,
        content: String?
    ) {
        self.id = id
        self.articleURL = articleURL
        self.title = title
        self.articleDescription = articleDescription
        self.imageURL = imageURL
        self.author = author
        self.publishedAt = publishedAt
        self.content = content
    }
}

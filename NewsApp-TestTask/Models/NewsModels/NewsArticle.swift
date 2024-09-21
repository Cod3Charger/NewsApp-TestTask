//
//  NewsArticle.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 20.09.2024.
//

import Foundation

struct NewsArticle: Codable, Hashable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String

    static func == (lhs: NewsArticle, rhs: NewsArticle) -> Bool {
        return lhs.title == rhs.title &&
        lhs.url == rhs.url &&
        lhs.publishedAt == rhs.publishedAt
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(url)
        hasher.combine(publishedAt)
    }
}

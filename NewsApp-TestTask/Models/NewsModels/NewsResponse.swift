//
//  NewsResponse.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 20.09.2024.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticle]
}

//
//  NewsService.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 20.09.2024.
//

import Foundation

class NewsService {

    private let apiKey = "95867a6426ce4db7af6c44235711d2cf"
    private let baseUrl = "https://newsapi.org/v2/everything"

    func fetchNews(for category: NewsCategory) async throws -> [NewsArticle] {
        guard let url = buildURL(for: category.rawValue) else {
            throw NewsServiceError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Api-Key")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NewsServiceError.requestFailed
        }

        do {
            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
            return newsResponse.articles
        } catch {
            throw NewsServiceError.decodingFailed
        }
    }

    private func buildURL(for query: String) -> URL? {
        var components = URLComponents(string: baseUrl)
        components?.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "pageSize", value: "10"),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "language", value: "en")
        ]
        return components?.url
    }
}

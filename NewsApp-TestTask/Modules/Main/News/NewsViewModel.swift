//
//  NewsViewModel.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class NewsViewModel: ObservableObject {

    @Published var articles: [NewsArticle] = []
    @Published var errorMessage: String?
    @Published var selectedSegment: NewsCategory = .travel {
        didSet {
            Task {
                await loadNews(for: selectedSegment)
            }
        }
    }
    @Published var isLoading: Bool = false

    private let newsService: NewsService
    let router: Router

    init(newsService: NewsService, router: Router) {
        self.newsService = newsService
        self.router = router
    }
}

// MARK: - Methods

extension NewsViewModel {

    @MainActor
    func loadNews(for category: NewsCategory) async {
        isLoading = true
        do {
            let fetchedArticles = try await newsService.fetchNews(for: category)
            self.articles = fetchedArticles
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }

    func loadTestArticles() {
        articles = [
            NewsArticle(
                source: Source(id: "1", name: "Test Source"),
                author: "John Doe",
                title: "Very Very Large First Test Article With Twelve Words And Two Symbols!!",
                description: "This is the description for the first test article.",
                url: "https://example.com/1",
                urlToImage: "https://24ai.tech/en/wp-content/uploads/sites/3/2023/10/01_product_1_sdelat-izobrazhenie-4-3-3-scaled.jpg",
                publishedAt: "2024-09-20T12:00:00Z"
            ),
            NewsArticle(
                source: Source(id: "2", name: "Test Source"),
                author: "Jane Smith",
                title: "Second Test Article",
                description: "This is the description for the second test article.",
                url: "https://example.com/2",
                urlToImage: "https://www.shootproof.com/wp-content/uploads/4-3-ratio_Morgan-Caddell-3955.jpg",
                publishedAt: "2024-09-20T12:05:00Z"
            ),
            NewsArticle(
                source: Source(id: "3", name: "Test Source"),
                author: "Alice Johnson",
                title: "Third Test Article",
                description: "This is the description for the third test article.",
                url: "https://example.com/3",
                urlToImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLKuFh33p42TjJCZ_QCCNCCj359LeIDoiddlOdPdUlE1yzfusRIQOkILNjnAv-tiJxnHM&usqp=CAU",
                publishedAt: "2024-09-20T12:10:00Z"
            )
        ]
    }
}

// MARK: - Router

extension NewsViewModel {
    struct Router {
        let navigateToNextScreen: () -> Void
    }
}

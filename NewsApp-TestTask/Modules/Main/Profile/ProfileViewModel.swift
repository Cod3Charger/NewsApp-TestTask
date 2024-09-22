//
//  ProfileViewModel.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class ProfileViewModel: ObservableObject {

    @Published var isPurchased: Bool = false
    @Published var bookmarks: [NewsArticle] = []
    @Published var isLoading: Bool = false

    let firebaseStorageManager: FirebaseStorageManager
    let storeKitManager: StoreKitManager
    let router: Router

    init(firebaseStorageManager: FirebaseStorageManager, storeKitManager: StoreKitManager, router: Router) {
        self.firebaseStorageManager = firebaseStorageManager
        self.storeKitManager = storeKitManager
        self.router = router

        Task {
            await checkSubscribe()
            if isPurchased {
                await loadBookmarks()
            }
        }
    }
}

// MARK: - Methods

extension ProfileViewModel {

    func checkSubscribe() async {
        if let product = storeKitManager.storeProducts.first(where: { $0.id == "com.newsapp" }) {
            do {
                isPurchased = try await storeKitManager.isPurchased(product)
            } catch {
                print("Failed to check purchase status: \(error)")
            }
        }
    }

    func loadBookmarks() async {
        isLoading = true
        await withCheckedContinuation { continuation in
            firebaseStorageManager.downloadAllArticles { result in
                self.isLoading = false
                switch result {
                case .success(let articles):
                    self.bookmarks = articles
                case .failure(let error):
                    print("Failed to load articles: \(error)")
                }
                continuation.resume()
            }
        }
    }

    func navigateToDetails(article: NewsArticle) {
        router.navigateToDetails(article)
    }
}

// MARK: - Router

extension ProfileViewModel {
    struct Router {
        let navigateToDetails: (NewsArticle) -> Void
    }
}


//
//  DetailsViewModel.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 20.09.2024.
//

import Foundation
import UIKit
import FirebaseStorage

final class DetailsViewModel: ObservableObject {

    @Published var isPurchased: Bool = false
    @Published var isAddedToBookmarks: Bool = false
    @Published var isLoading: Bool = false 

    let article: NewsArticle

    let firebaseStorageManager: FirebaseStorageManager
    let storeKitManager: StoreKitManager
    let router: Router

    init(article: NewsArticle, firebaseStorageManager: FirebaseStorageManager, storeKitManager: StoreKitManager, router: Router) {
        self.article = article
        self.firebaseStorageManager = firebaseStorageManager
        self.storeKitManager = storeKitManager
        self.router = router

        Task {
            await checkSubscribe()
            await checkIfArticleExists()
        }
    }
}

// MARK: - Methods

extension DetailsViewModel {

    func checkSubscribe() async {
        if let product = storeKitManager.storeProducts.first(where: { $0.id == "com.newsapp" }) {
            do {
                isPurchased = try await storeKitManager.isPurchased(product)
            } catch {
                print("Failed to check purchase status: \(error)")
            }
        }
    }

    func openOriginalArticle() {
        if let url = URL(string: article.url) {
            UIApplication.shared.open(url)
        }
    }

    func uploadArticle() {
        isLoading = true

        firebaseStorageManager.uploadArticleToStorage(article: article) { [self] result in
            isLoading = false

            switch result {
            case .success(let url):
                self.isAddedToBookmarks = true
                print("Article uploaded successfully. URL: \(url)")
            case .failure(let error):
                self.isAddedToBookmarks = false
                print("Failed to upload article: \(error)")
            }
        }
    }

    func checkIfArticleExists() async {
        firebaseStorageManager.articleExists(articleTitle: article.title) { result in
            switch result {
            case .success(let exists):
                self.isAddedToBookmarks = exists
            case .failure(let error):
                print("Failed to check if article exists: \(error)")
            }
        }
    }

    func navigateToNewsScreen() {
        router.navigateToNewsScreen()
    }
}

// MARK: - Router

extension DetailsViewModel {
    struct Router {
        let navigateToNewsScreen: () -> Void
    }
}


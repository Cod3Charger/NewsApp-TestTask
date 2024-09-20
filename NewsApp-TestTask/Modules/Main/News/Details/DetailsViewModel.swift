//
//  DetailsViewModel.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 20.09.2024.
//

import Foundation

final class DetailsViewModel: ObservableObject {

    let article: NewsArticle
    let router: Router

    init(article: NewsArticle, router: Router) {
        self.article = article
        self.router = router
    }
}

// MARK: - Methods

extension DetailsViewModel {
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


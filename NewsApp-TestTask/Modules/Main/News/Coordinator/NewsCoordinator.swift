//
//  NewsCoordinator.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class NewsCoordinator: Coordinator {

    enum Screen: Routable {
        case news
    }

    @Published var navigationPath: [Screen] = []

    var goToDetailsScreen: ((NewsArticle) -> Void)

    init(goToDetailsScreen: @escaping ((NewsArticle) -> Void)) {
        self.goToDetailsScreen = goToDetailsScreen
    }

    func navigateToDetails(article: NewsArticle) {
        goToDetailsScreen(article)
    }

    func popToRoot() {
        navigationPath.removeAll()
        navigationPath.append(.news)
    }

    func pop() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }

    func push(screen: Screen) {
        navigationPath.append(screen)
    }
}

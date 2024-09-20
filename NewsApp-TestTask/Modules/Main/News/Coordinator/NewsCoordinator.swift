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
        case details(NewsArticle)
    }

    @Published var navigationPath: [Screen] = []

    var goToDetailsScreen: (() -> Void)?
    var onTabBarVisibilityChange: ((Bool) -> Void)?

    init(goToNextScreen: (() -> Void)? = nil, onTabBarVisibilityChange: ((Bool) -> Void)? = nil) {
        self.goToDetailsScreen = goToNextScreen
        self.onTabBarVisibilityChange = onTabBarVisibilityChange
    }

    func navigateToDetails(article: NewsArticle) {
        onTabBarVisibilityChange?(true)
        navigationPath.append(.details(article))
    }

    func popToRoot() {
        navigationPath.removeAll()
        navigationPath.append(.news)
    }

    func pop() {
        if !navigationPath.isEmpty {
            onTabBarVisibilityChange?(false)
            navigationPath.removeLast()
        }
    }

    func push(screen: Screen) {
        navigationPath.append(screen)
    }
}

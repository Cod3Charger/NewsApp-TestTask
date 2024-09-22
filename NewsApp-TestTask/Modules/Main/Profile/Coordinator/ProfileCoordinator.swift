//
//  ProfileCoordinator.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class ProfileCoordinator: Coordinator {

    enum Screen: Routable {
        case profile
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
        navigationPath.append(.profile)
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

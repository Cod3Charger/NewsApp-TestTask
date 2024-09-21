//
//  DetailsCoordinator.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 21.09.2024.
//
import Foundation

final class DetailsCoordinator: Coordinator {

    enum Screen: Routable {
        case details(NewsArticle)
    }

    @Published var navigationPath: [Screen] = []

    var article: NewsArticle?
    var goToNewsScreen: (() -> Void)

    init(article: NewsArticle, goToNewsScreen: @escaping (() -> Void)) {
        self.article = article
        self.goToNewsScreen = goToNewsScreen
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

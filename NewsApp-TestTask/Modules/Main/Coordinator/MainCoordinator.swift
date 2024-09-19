//
//  MainCoordinator.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class MainCoordinator: Coordinator {

    enum Screen: Routable {
        case main
    }

    @Published var navigationPath: [Screen] = []

    var goToNextScreen: (() -> Void)?

    init(goToNextScreen: (() -> Void)? = nil) {
        self.goToNextScreen = goToNextScreen
    }

    func popToRoot() {
        navigationPath.removeAll()
        navigationPath.append(.main)
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


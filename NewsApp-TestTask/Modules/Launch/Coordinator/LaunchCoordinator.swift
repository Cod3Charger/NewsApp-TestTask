//
//  LaunchCoordinator.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class LaunchCoordinator: Coordinator {

    enum Screen: Routable {
        case launch
    }

    @Published var navigationPath: [Screen] = []

    func popToRoot() {
        navigationPath.removeAll()
        navigationPath.append(.launch)
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

//
//  PaywallCoordinator.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class PaywallCoordinator: Coordinator {

    enum Screen: Routable {
        case paywall
    }

    @Published var navigationPath: [Screen] = []

    var goToNextScreen: (() -> Void)?

    init(goToNextScreen: (() -> Void)? = nil) {
        self.goToNextScreen = goToNextScreen
    }

    func popToRoot() {
        navigationPath.removeAll()
        navigationPath.append(.paywall)
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

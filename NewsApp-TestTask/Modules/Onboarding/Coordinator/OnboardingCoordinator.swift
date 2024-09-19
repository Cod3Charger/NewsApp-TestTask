//
//  OnboardingCoordinator.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class OnboardingCoordinator: Coordinator {

    enum Screen: Routable {
        case onboarding
    }

    @Published var navigationPath: [Screen] = []

    var goToNextScreen: (() -> Void)?

    init(goToNextScreen: (() -> Void)? = nil) {
        self.goToNextScreen = goToNextScreen
    }

    func popToRoot() {
        navigationPath.removeAll()
        navigationPath.append(.onboarding)
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

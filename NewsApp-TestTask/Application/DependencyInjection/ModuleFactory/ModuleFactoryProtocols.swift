//
//  ModuleFactoryProtocols.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

@MainActor
protocol LaunchViewFactory {
    func makeLaunchView(coordinator: LaunchCoordinator) -> LaunchView
}

@MainActor
protocol OnboardingViewFactory {
    func makeOnboardingView(coordinator: OnboardingCoordinator) -> OnboardingView
}

@MainActor
protocol PaywallViewFactory {
    func makePaywallView(coordinator: PaywallCoordinator) -> PaywallView
}

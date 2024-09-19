//
//  ModuleFactory.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class ModuleFactory: CoordinatorFactory {
    /*
     Here can be other factories, builders, etc
     */
}

// MARK: LaunchViewFactory

extension ModuleFactory: LaunchViewFactory {

    func makeLaunchView(coordinator: LaunchCoordinator) -> LaunchView {

        let router = LaunchViewModel.Router.init(
            navigateToNextScreen: {
                coordinator.goToNextScreen?()
            }
        )

        let viewModel = LaunchViewModel(
            router: router
        )

        return LaunchView(viewModel: viewModel)
    }
}

// MARK: OnboardingViewFactory

extension ModuleFactory: OnboardingViewFactory {

    func makeOnboardingView(coordinator: OnboardingCoordinator) -> OnboardingView {

        let router = OnboardingViewModel.Router.init()

        let viewModel = OnboardingViewModel(
            router: router
        )

        return OnboardingView(viewModel: viewModel)
    }
}

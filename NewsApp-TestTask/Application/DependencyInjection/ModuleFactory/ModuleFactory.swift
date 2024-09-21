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

    let storeKitManager = StoreKitManager()
    let newsService = NewsService()
}

// MARK: LaunchViewFactory

extension ModuleFactory: LaunchViewFactory {

    func makeLaunchView(coordinator: LaunchCoordinator) -> LaunchView {

        let router = LaunchViewModel.Router.init {
            coordinator.goToNextScreen?()
        }

        let viewModel = LaunchViewModel(
            router: router
        )

        return LaunchView(viewModel: viewModel)
    }
}

// MARK: OnboardingViewFactory

extension ModuleFactory: OnboardingViewFactory {

    func makeOnboardingView(coordinator: OnboardingCoordinator) -> OnboardingView {

        let router = OnboardingViewModel.Router.init {
            coordinator.goToNextScreen?()
        }

        let viewModel = OnboardingViewModel(
            router: router
        )

        return OnboardingView(viewModel: viewModel)
    }
}

// MARK: PaywallViewFactory

extension ModuleFactory: PaywallViewFactory {
    func makePaywallView(coordinator: PaywallCoordinator) -> PaywallView {

        let router = PaywallViewModel.Router.init {
            coordinator.goToNextScreen?()
        }

        let viewModel = PaywallViewModel(
            storeKitManager: storeKitManager,
            router: router
        )

        return PaywallView(viewModel: viewModel)
    }
}

// MARK: NewsViewFactory

extension ModuleFactory: NewsViewFactory {

    func makeNewsView(coordinator:  NewsCoordinator) -> NewsView {

        let router = NewsViewModel.Router.init { article in
            coordinator.navigateToDetails(article: article)
        }

        let viewModel = NewsViewModel(
            newsService: newsService,
            router: router
        )

        return NewsView(viewModel: viewModel)
    }
}

// MARK: ProfileViewFactory

extension ModuleFactory: ProfileViewFactory {

    func makeProfileView(coordinator:  ProfileCoordinator) -> ProfileView {

        let router = ProfileViewModel.Router.init {}

        let viewModel = ProfileViewModel(
            storeKitManager: storeKitManager,
            router: router
        )

        return ProfileView(viewModel: viewModel)
    }
}

// MARK: ProfileViewFactory

extension ModuleFactory: DetailsViewFactory {

    func makeDetailsView(coordinator: DetailsCoordinator, article: NewsArticle) -> DetailsView {

        let router = DetailsViewModel.Router.init {
            coordinator.goToNewsScreen()
        }

        let viewModel = DetailsViewModel(
            article: article,
            router: router
        )

        return DetailsView(viewModel: viewModel)
    }
}


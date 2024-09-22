//
//  AppCoordinatorView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct AppCoordinatorView: View {

    private let moduleFactory: ModuleFactory

    @ObservedObject private var coordinator: AppCoordinator

    init(moduleFactory: ModuleFactory, coordinator: AppCoordinator) {
        self.moduleFactory = moduleFactory
        self.coordinator = coordinator
    }

    var body: some View {
        self.scene
            .onAppear {
                self.coordinator.change(flow: .launch)
            }
    }

    @ViewBuilder
    private var scene: some View {
        switch self.coordinator.flow {
        case .launch:
            LaunchCoordinatorView(
                moduleFactory: self.moduleFactory,
                coordinator: LaunchCoordinator(goToNextScreen: {
                    self.coordinator.change(flow: .onboarding)
                })
            )
            .transition(.opacity)
        case .onboarding:
            OnboardingCoordinatorView(
                moduleFactory: self.moduleFactory,
                coordinator: OnboardingCoordinator(goToNextScreen: {
                    self.coordinator.change(flow: .paywall)
                })
            )
            .transition(.opacity)
        case .paywall:
            PaywallCoordinatorView(
                moduleFactory: self.moduleFactory,
                coordinator: PaywallCoordinator(goToNextScreen: {
                    self.coordinator.change(flow: .main)
                })
            )
            .transition(.opacity)
        case .main:
            MainCoordinatorView(
                moduleFactory: self.moduleFactory,
                coordinator: MainCoordinator(goToDetails: { article in
                    self.coordinator.change(flow: .details(article))
                })
            )
            .transition(.opacity)
        case .details(let article):
            DetailsCoordinatorView(
                moduleFactory: self.moduleFactory,
                coordinator: DetailsCoordinator(
                    article: article,
                    goToNewsScreen: {
                        self.coordinator.change(flow: .main )
                    })
            )
            .transition(.opacity)
        }
    }
}

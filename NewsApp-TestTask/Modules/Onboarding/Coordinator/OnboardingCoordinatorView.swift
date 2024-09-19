//
//  OnboardingCoordinatorView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct OnboardingCoordinatorView: View {

    private let moduleFactory: CoordinatorFactory

    @StateObject private var coordinator: OnboardingCoordinator

    init(moduleFactory: CoordinatorFactory, coordinator: OnboardingCoordinator) {
        self.moduleFactory = moduleFactory
        self._coordinator = StateObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationStack(
            path: self.$coordinator.navigationPath) {
                self.destination(.onboarding)
                    .navigationDestination(for: OnboardingCoordinator.Screen.self) {
                        self.destination($0)
                            .navigationBarBackButtonHidden()
                    }
            }
    }

    @ViewBuilder
    private func destination(_ screen: OnboardingCoordinator.Screen) -> some View {
        switch screen {
        case .onboarding:
            self.moduleFactory.makeOnboardingView(coordinator: self.coordinator)
        }
    }
}


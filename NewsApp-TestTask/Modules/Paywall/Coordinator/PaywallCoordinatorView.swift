//
//  PaywallCoordinatorView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

import SwiftUI

struct PaywallCoordinatorView: View {

    private let moduleFactory: CoordinatorFactory

    @StateObject private var coordinator: PaywallCoordinator

    init(moduleFactory: CoordinatorFactory, coordinator: PaywallCoordinator) {
        self.moduleFactory = moduleFactory
        self._coordinator = StateObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationStack(
            path: self.$coordinator.navigationPath) {
                self.destination(.paywall)
                    .navigationDestination(for: PaywallCoordinator.Screen.self) {
                        self.destination($0)
                            .navigationBarBackButtonHidden()
                    }
            }
    }

    @ViewBuilder
    private func destination(_ screen: PaywallCoordinator.Screen) -> some View {
        switch screen {
        case .paywall:
            self.moduleFactory.makePaywallView(coordinator: self.coordinator)
        }
    }
}

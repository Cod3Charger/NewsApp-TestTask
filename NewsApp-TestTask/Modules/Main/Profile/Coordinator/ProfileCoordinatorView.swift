//
//  ProfileCoordinatorView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct ProfileCoordinatorView: View {

    private let moduleFactory: CoordinatorFactory

    @StateObject private var coordinator: ProfileCoordinator

    init(moduleFactory: CoordinatorFactory, coordinator: ProfileCoordinator) {
        self.moduleFactory = moduleFactory
        self._coordinator = StateObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationStack(
            path: self.$coordinator.navigationPath) {
                self.destination(.profile)
                    .navigationDestination(for: ProfileCoordinator.Screen.self) {
                        self.destination($0)
                            .navigationBarBackButtonHidden()
                    }
            }
    }

    @ViewBuilder
    private func destination(_ screen: ProfileCoordinator.Screen) -> some View {
        switch screen {
        case .profile:
            self.moduleFactory.makeProfileView(coordinator: self.coordinator)
        }
    }
}

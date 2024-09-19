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
                coordinator: LaunchCoordinator()
            )
                .transition(.opacity)
        }
    }
}

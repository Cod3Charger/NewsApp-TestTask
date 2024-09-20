//
//  NewsCoordinatorView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct NewsCoordinatorView: View {

    private let moduleFactory: CoordinatorFactory

    @StateObject private var coordinator: NewsCoordinator

    init(moduleFactory: CoordinatorFactory, coordinator: NewsCoordinator) {
        self.moduleFactory = moduleFactory
        self._coordinator = StateObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationStack(
            path: self.$coordinator.navigationPath) {
                self.destination(.news)
                    .navigationDestination(for: NewsCoordinator.Screen.self) {
                        self.destination($0)
                            .navigationBarBackButtonHidden()
                    }
            }
    }

    @ViewBuilder
    private func destination(_ screen: NewsCoordinator.Screen) -> some View {
        switch screen {
        case .news:
            self.moduleFactory.makeNewsView(coordinator: self.coordinator)
        case .details(let article):
            self.moduleFactory.makeDetailsView(coordinator: self.coordinator, article: article)
        }
    }
}


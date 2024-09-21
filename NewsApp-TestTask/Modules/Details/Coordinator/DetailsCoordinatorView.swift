//
//  DetailsCoordinatorView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 21.09.2024.
//

import SwiftUI

struct DetailsCoordinatorView: View {

    private let moduleFactory: CoordinatorFactory

    @StateObject private var coordinator: DetailsCoordinator

    init(moduleFactory: CoordinatorFactory, coordinator: DetailsCoordinator) {
        self.moduleFactory = moduleFactory
        self._coordinator = StateObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationStack(
            path: self.$coordinator.navigationPath) {
                if let article = coordinator.article {
                    self.destination(.details(article))
                        .navigationDestination(for: DetailsCoordinator.Screen.self) {
                            self.destination($0)
                                .navigationBarBackButtonHidden()
                        }
                }
            }
    }

    @ViewBuilder
    private func destination(_ screen: DetailsCoordinator.Screen) -> some View {
        switch screen {
        case .details(let article):
            self.moduleFactory.makeDetailsView(coordinator: self.coordinator, article: article)
        }
    }
}


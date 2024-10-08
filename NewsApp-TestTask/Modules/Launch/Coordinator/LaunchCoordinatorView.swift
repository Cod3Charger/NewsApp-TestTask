//
//  LaunchCoordinatorView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct LaunchCoordinatorView: View {
    
    private let moduleFactory: CoordinatorFactory
    
    @StateObject private var coordinator: LaunchCoordinator
    
    init(moduleFactory: CoordinatorFactory, coordinator: LaunchCoordinator) {
        self.moduleFactory = moduleFactory
        self._coordinator = StateObject(wrappedValue: coordinator)
    }
    
    var body: some View {
        NavigationStack(
            path: self.$coordinator.navigationPath) {
                self.destination(.launch)
                    .navigationDestination(for: LaunchCoordinator.Screen.self) {
                        self.destination($0)
                            .navigationBarBackButtonHidden()
                    }
            }
    }
    
    @ViewBuilder
    private func destination(_ screen: LaunchCoordinator.Screen) -> some View {
        switch screen {
        case .launch:
            self.moduleFactory.makeLaunchView(coordinator: self.coordinator)
        }
    }
}

//
//  NewsAppTestTaskApp.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 18.09.2024.
//

import SwiftUI

@main
struct NewsAppTestTaskApp: App {

    private let moduleFactory: ModuleFactory = {
        return ModuleFactory()
    }()

    private let appCoordinator = AppCoordinator()

    // TODO: remove later
    init () {
        for family in  UIFont .familyNames {
            print ( "Family: \(family) " )
            for name in  UIFont .fontNames(forFamilyName: family) {
                print ( " - \(name) " )
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(moduleFactory: self.moduleFactory, coordinator: self.appCoordinator)
        }
    }
}

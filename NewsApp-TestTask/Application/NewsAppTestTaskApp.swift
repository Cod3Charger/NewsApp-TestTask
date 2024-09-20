//
//  NewsAppTestTaskApp.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 18.09.2024.
//

import SwiftUI
import FirebaseCore

@main
struct NewsAppTestTaskApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    private let moduleFactory: ModuleFactory = {
        return ModuleFactory()
    }()

    private let appCoordinator = AppCoordinator()

    init() {
        FirebaseApp.configure() 
    }

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(moduleFactory: self.moduleFactory, coordinator: self.appCoordinator)
        }
    }
}

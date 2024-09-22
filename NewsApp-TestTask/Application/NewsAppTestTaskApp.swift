//
//  NewsAppTestTaskApp.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 18.09.2024.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct NewsAppTestTaskApp: App {

    private let moduleFactory: ModuleFactory = {
        return ModuleFactory()
    }()

    private let appCoordinator = AppCoordinator()

    init() {
        FirebaseApp.configure()
        for family: String in UIFont.familyNames {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(moduleFactory: self.moduleFactory, coordinator: self.appCoordinator).onOpenURL { url in
                GIDSignIn.sharedInstance.handle(url)
            }
        }
        .environment(\.colorScheme, .light)
    }
}

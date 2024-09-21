//
//  OnboardingViewModel.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation
import FirebaseAuth

final class OnboardingViewModel: ObservableObject {

    @Published var userLoggedIn = (Auth.auth().currentUser != nil)
    @Published var showErrorAlert = false
    @Published var error = ""

    let router: Router

    init(router: Router) {
        self.router = router
    }
}

// MARK: - Methods

extension OnboardingViewModel {
    func login() {
        Task {
            do {
                try await Authentication().googleOauth()
            } catch AuthenticationError.runtimeError(let error) {
                self.error = error
            }
        }
    }

    func logout() {
        Task {
            do {
                try await Authentication().logout()
                userLoggedIn = false
            } catch {
                self.error = "Failed to log out"
                showErrorAlert = true
            }
        }
    }

    func setListener() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if (user !=  nil ) {
                self.userLoggedIn =  true
            } else {
                self.userLoggedIn =  false
            }
        }
    }
}

// MARK: - Router

extension OnboardingViewModel {
    struct Router {
        let navigateToNextScreen: () -> Void
    }
}

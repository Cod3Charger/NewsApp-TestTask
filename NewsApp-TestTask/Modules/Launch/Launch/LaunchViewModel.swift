//
//  LaunchViewModel.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class LaunchViewModel: ObservableObject {

    let router: Router

    init(router: Router) {
        self.router = router
    }
}

// MARK: - Methods

extension LaunchViewModel {
    func startTimer() {
        // TODO: add time
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.navigateToNextScreen()
        }
    }
}

// MARK: - Private Methods

extension LaunchViewModel {
    private func navigateToNextScreen() {
        router.navigateToNextScreen()
    }
}

// MARK: - Router

extension LaunchViewModel {
    struct Router {
        let navigateToNextScreen: () -> Void
    }
}

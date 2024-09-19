//
//  ProfileViewModel.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class ProfileViewModel: ObservableObject {

    let router: Router

    init(router: Router) {
        self.router = router
    }
}

// MARK: - Router

extension ProfileViewModel {
    struct Router {
        let navigateToNextScreen: () -> Void
    }
}


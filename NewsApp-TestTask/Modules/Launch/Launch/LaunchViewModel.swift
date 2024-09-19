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

// MARK: - Router

extension LaunchViewModel {
    struct Router {}
}

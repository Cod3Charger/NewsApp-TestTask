//
//  ModuleFactory.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class ModuleFactory: MainCoordinatorFactory {
    /*
     Here can be other factories, builders, etc
     */
}

// MARK: LaunchViewFactory

extension ModuleFactory: LaunchViewFactory {

    func makeLaunchView(coordinator: LaunchCoordinator) -> LaunchView {

        let router = LaunchViewModel.Router.init()

        let viewModel = LaunchViewModel(
            router: router
        )

        return LaunchView(viewModel: viewModel)
    }
}

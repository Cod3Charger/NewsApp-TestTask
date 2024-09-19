//
//  AppCoordinator.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class AppCoordinator: ObservableObject {

    enum Flow {
        case launch
    }

    @Published var flow: Flow = .launch

    func change(flow: Flow) {
        self.flow = flow
    }
}

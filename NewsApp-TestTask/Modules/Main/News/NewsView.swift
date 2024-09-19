//
//  NewsView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct NewsView: View {

    @StateObject private var viewModel: NewsViewModel

    init(viewModel: NewsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Text("News")
    }
}

#Preview {
    let moduleFactory = ModuleFactory()
    let coordinator = NewsCoordinator()

    return moduleFactory.makeNewsView(coordinator: coordinator)
}


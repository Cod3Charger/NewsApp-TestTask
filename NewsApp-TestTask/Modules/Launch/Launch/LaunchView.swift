//
//  LaunchView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct LaunchView: View {

    @StateObject private var viewModel: LaunchViewModel

    init(viewModel: LaunchViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Text("NewsApp").font(Font.interSemiBold60)
            .onAppear {
                viewModel.startTimer()
            }
    }
}

#Preview {
    let moduleFactory = ModuleFactory()
    let coordinator = LaunchCoordinator()

    return moduleFactory.makeLaunchView(coordinator: coordinator)
}

//
//  OnboardingView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct OnboardingView: View {

    @StateObject private var viewModel: OnboardingViewModel

    init(viewModel: OnboardingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel) 
    }

    var body: some View {
        Text("Onboarding")
    }
}

#Preview {
    let moduleFactory = ModuleFactory()
    let coordinator = OnboardingCoordinator()

    return moduleFactory.makeOnboardingView(coordinator: coordinator)
}

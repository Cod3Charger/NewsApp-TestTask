//
//  ProfileView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct ProfileView: View {

    @StateObject private var viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Text("Profile")
    }
}

#Preview {
    let moduleFactory = ModuleFactory()
    let coordinator = ProfileCoordinator()

    return moduleFactory.makeProfileView(coordinator: coordinator)
}

